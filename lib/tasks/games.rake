# require 'rest-client'
require 'mechanize'
namespace :games do
  task :read => :environment do
    mechanize = Mechanize.new
    mechanize.get('http://www.eisbaeren.de/spielplan-tabelle/spielplan').search("#content .news_list.event_list .entry .info").each do |game|
      @spiel = []
      reader = Nokogiri::XML::Reader(game)
      reader.source.gsub("\t", " ").split("\n").each do |row|
        if row.present?
          @spiel.push(row.strip)
        end
      end
      game_datetime = DateTime.strptime((@spiel[0] + " " + @spiel[1]), '%d.%m.%Y %H:%M')
      home_team = Team.find_by(name: @spiel[2])
      away_team = Team.find_by(name: @spiel[3])

      if Game.first.nil?
        game_number = 1
        current_game = true
      else
        game_number = Game.last.game_number.to_i + 1
        current_game = false
      end

      if game_datetime.present? && home_team.present? && away_team.present?
        if Game.find_by(game_date: game_datetime, home_team_id: home_team.id, away_team_id: away_team.id).nil?
          Game.create(game_date:    game_datetime,
                      home_team_id: home_team.id,
                      away_team_id: away_team.id,
                      game_number:  game_number,
                      current:      current_game)
        else
          # TODO:
        end
      end
    end
  end

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
            tip.price = 2
          elsif game.home_goals == tip.home_goals && game.away_goals == tip.away_goals
            tip.price = 0
          elsif ((game.home_goals > game.away_goals) && (tip.home_goals > tip.away_goals)) || ((game.home_goals < game.away_goals) && (tip.home_goals < tip.away_goals))
            diff = (game.home_goals - tip.home_goals).abs + (game.away_goals - tip.away_goals).abs
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
