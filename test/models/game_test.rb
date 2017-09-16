require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test "should not save game without a home_team_id" do
    game = Game.new(away_team_id: 1, game_date: Time.now)
    assert_not game.save
  end
  test "should not save game without an away_team_id" do
    game = Game.new(home_team_id: 1, game_date: Time.now)
    assert_not game.save
  end
  test "should not save game without a game date" do
    game = Game.new(home_team_id: 1, away_team_id: 1)
    assert_not game.save
  end
end
