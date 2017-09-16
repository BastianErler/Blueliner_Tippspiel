require 'test_helper'

class TipEvaluationTest < ActionDispatch::IntegrationTest
  setup do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    @game = FactoryGirl.create(:game,
                               game_number: 1,
                               game_date: Time.now - 1.days,
                               home_goals: 6,
                               away_goals: 2,
                               state: 'closed',
                               current: false,
                               evaluated: false)
    @user = FactoryGirl.create(:user)
    @tip = FactoryGirl.create(:tip,
                              game_id: @game.id,
                              user_id: @user.id)
  end
  teardown do
    DatabaseCleaner.clean
  end
  test 'correct tip should cost 00 Cent' do
    @tip.update_attributes(home_goals: 6, away_goals: 2)
    @tip.evaluate
    assert_equal(0, @tip.price)
  end
  test 'wrong winner tip should cost 100 Cent' do
    @tip.update_attributes(home_goals: 2, away_goals: 6)
    @tip.evaluate
    assert_equal(1, @tip.price)
  end
  test 'not tipping should cost 100 Cent' do
    @tip.update_attributes(home_goals: nil, away_goals: nil)
    @tip.evaluate
    assert_equal(1, @tip.price)
  end
  test '1 home_goal lower with correct tendency should cost 20 Cent' do
    @tip.update_attributes(home_goals: 5, away_goals: 2)
    @tip.evaluate
    assert_equal(0.2, @tip.price)
  end
  test '1 away_goal lower with correct tendency should cost 20 Cent' do
    @tip.update_attributes(home_goals: 6, away_goals: 1)
    @tip.evaluate
    assert_equal(0.2, @tip.price)
  end
  test '1 home_goal higher with correct tendency should cost 20 Cent' do
    @tip.update_attributes(home_goals: 7, away_goals: 2)
    @tip.evaluate
    assert_equal(0.2, @tip.price)
  end
  test '1 away_goal higher with correct tendency should cost 20 Cent' do
    @tip.update_attributes(home_goals: 6, away_goals: 3)
    @tip.evaluate
    assert_equal(0.2, @tip.price)
  end
end
