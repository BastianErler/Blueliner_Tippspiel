# StaticPagesController
class StaticPagesController < ApplicationController
  def home
    @game = Game.where(current: true).first
    @user = current_user
    @game_without_score = Game.where(state: 'closed', home_goals: nil, away_goals: nil).first
  end

  def help; end

  def rules; end
end
