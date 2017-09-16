require 'test_helper'

class TipTest < ActiveSupport::TestCase
  test "should not save tip without a user_id" do
    tip = Tip.new(game_id: 1)
    assert_not tip.save
  end
  test "should not save tip without a game_id" do
    tip = Tip.new(user_id: 1)
    assert_not tip.save
  end
  test "should not save tip with string as goals" do
    tip = Tip.new(user_id: 1,
                  game_id: 1,
                  home_goals: 'FooBar',
                  away_goals: 'FooBar')
    assert_not tip.save
  end
end
