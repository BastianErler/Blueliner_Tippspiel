require 'test_helper'

class GameClosingTest < ActionDispatch::IntegrationTest
  setup do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
    @game1 = FactoryGirl.create(:game,
                                game_number: 1,
                                game_date: Time.now + 6.hours,
                                state: 'open',
                                current: true,
                                evaluated: false)
  end
  teardown do
    DatabaseCleaner.clean
  end
  test 'game should be closeable if time till start < 6 hours' do
    @game1.close
    assert_equal('closed', @game1.state)
  end
  test 'game should not be closeable if time till start > 6 hours' do
    @game1.update_attributes(game_date: Time.now + 1.days)
    @game1.close
    assert_equal('open', @game1.reload.state)
  end
  test 'game close should create the missing tips' do
    10.times {FactoryGirl.create(:user)}
    @game1.close
    assert_equal(User.all.count, Tip.where(game_id: @game1.reload.id).all.count)
  end
  test 'tips create by game close should have nil goals' do
    FactoryGirl.create(:user)
    @game1.close
    assert_nil(Tip.first.home_goals)
    assert_nil(Tip.first.away_goals)
  end
  test 'game close should set the next game in line as current game' do
    game2 = FactoryGirl.create(:game,
                               game_number: 1,
                               game_date: Time.now + 1.days,
                               state: 'open',
                               current: false,
                               evaluated: false)
    game3 = FactoryGirl.create(:game,
                               game_number: 1,
                               game_date: Time.now + 3.days,
                               state: 'open',
                               current: false,
                               evaluated: false)
    @game1.close
    assert_equal(false, @game1.current)
    assert_equal(true, game2.reload.current)
    assert_equal(false, game3.reload.current)
  end
end
