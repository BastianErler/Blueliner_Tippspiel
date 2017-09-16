class Tip < ApplicationRecord
  belongs_to :user
  belongs_to :game
  validates :game_id, presence: true
  validates :user_id, presence: true
  def evaluate
    if goals_nil
      self.price = 1
    elsif tip_correct
      self.price = 0
    elsif tendency_correct
      diff = calculate_diff
      self.price = [diff * 0.20, 0.80].min
    else
      self.price = 1
    end
    save
  end

  private

  def goals_nil
    (home_goals.nil? && away_goals.nil?)
  end

  def tip_correct
    ((game.home_goals == home_goals) &&
        (game.away_goals == away_goals))
  end

  def tendency_correct
    ((game.home_goals > game.away_goals) && (home_goals > away_goals)) ||
      ((game.home_goals < game.away_goals) && (home_goals < away_goals))
  end

  def calculate_diff
    (game.home_goals - home_goals).abs +
      (game.away_goals - away_goals).abs
  end
end
