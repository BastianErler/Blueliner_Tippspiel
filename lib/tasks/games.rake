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
      binding.pry
    end
    puts page.title
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
        end
        game.evaluated = true
        game.save
      end
    end
  end
end
