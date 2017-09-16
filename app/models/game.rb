class Game < ApplicationRecord
  validates :game_date, presence: true
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true
  validate :game_can_only_be_closed_6_hours_before_start, on: :update

  has_many :tips
  # belongs_to :season

  def close
    @game = self
    update_attributes(state: 'closed', current: false)
    create_missing_tips_with_nil
    set_next_game_as_current
  end

  def evaluate
    self.tips.each do |tip|
      tip.evaluate
      tip.user.sum_money_out = tip.user.tips.sum(:price)
      tip.user.save
    end
  end

  def score_set
    (home_goals.present? && away_goals.present?)
  end

  def set_next_game_as_current
    game = Game.where('game_date > ?', @game.game_date)
               .order(game_date: :asc)
               .first
    game.update_attributes(current: true) if game.present?
    game.save if game.present?
  end

  def create_missing_tips_with_nil
    User.all.each do |user|
      Tip.find_or_create_by(game_id: id, user_id: user.id)
    end
  end

  def game_can_only_be_closed_6_hours_before_start
    errors.add(:state, 'to early to close the game') if (game_date - 6.hours > Time.now) && (state == 'closed')
  end
end
