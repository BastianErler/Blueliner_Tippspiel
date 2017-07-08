class Game < ApplicationRecord
  validates :game_date,    presence: true
  validates :home_team_id, presence: true
  validates :away_team_id, presence: true

  has_many :tips
  # belongs_to :season
end
