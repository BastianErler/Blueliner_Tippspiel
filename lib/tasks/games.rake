# require 'rest-client'
namespace :games do
  task :close => :environment do
    Game.where(state: 'open').each do |game|
      if game.game_date < Time.now.utc
        game.state = 'closed'
        game.save
        if game.current?
          new_cur = Game.where("game_date > ?", Time.now.utc).order("game_date ASC").limit(1).first
          new_cur.current = true
          game.current = false
          new_cur.save
        end
      end
    end
  end

  task :evaluate => :environment do
    Game.where(evaluated: false).each do |game|
      if (game.home_goals.present? and game.away_goals.present?)
        puts 'evaluating...'
        game.evaluated = true
        game.save
      end
    end
  end
end
