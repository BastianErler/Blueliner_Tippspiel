# require 'rest-client'
require 'mechanize'
namespace :games do

  task :close => :environment do
    Game.where(state: 'open').each do |game|
      if game.game_date - 6.hours < Time.now
        game.state = 'closed'
        game.save
        if game.current?
          new_cur = Game.where("game_date > ?", Time.now).order("game_date ASC").limit(1).first
          new_cur.current = true
          game.current = false
          new_cur.save
          game.save
        end
      end
    end
  end

  task :evaluate => :environment do
    Game.where(evaluated: false).each do |game|
      if (game.home_goals.present? and game.away_goals.present?)
        puts 'evaluating...'
        game.tips.each do |tip|
          if tip.home_goals.nil? && tip.away_goals.nil?
            tip.price = 1
          elsif game.home_goals == tip.home_goals && game.away_goals == tip.away_goals
            tip.price = 0
          elsif ((game.home_goals > game.away_goals) && (tip.home_goals > tip.away_goals)) ||
             ((game.home_goals < game.away_goals) && (tip.home_goals < tip.away_goals))
            diff = (game.home_goals - tip.home_goals).abs +
             (game.away_goals - tip.away_goals).abs
            tip.price = diff * 0.20
          else
            tip.price = 1
          end
          tip.save
          tip.user.sum_money_out = tip.user.tips.sum(:price)
          tip.user.save
        end
        game.evaluated = true
        game.save
      end
    end
  end
end
