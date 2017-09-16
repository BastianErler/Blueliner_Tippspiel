# require 'rest-client'
require 'mechanize'
namespace :games do

  task close: :environment do
    Game.where(current: true).each do |game|
      game.close
    end
  end

  task evaluate: :environment do
    Game.where(evaluated: false).each do |game|
      next unless game.score_set
      game.evaluate
      game.evaluated = true
      game.save
    end
  end
end
