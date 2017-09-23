class TipsController < ApplicationController
  before_action :logged_in_user, only: [:edit]

  def edit
    @tip = Tip.find_or_create_by(game_id: params[:id], user_id: current_user.id)
    @game = Game.find_by(id: params[:id])
    @home_team = Team.find_by(id: @game.home_team_id)
    @away_team = Team.find_by(id: @game.away_team_id)
    if @game.state == 'closed' && current_user.admin? && @game.evaluated == false
      flash[:warning] = 'Spiel geschlossen'
      redirect_to edit_game_url
    elsif @game.state == 'closed'
      flash[:warning] = 'Spiel geschlossen'
      redirect_to game_path
    end
  end

  def update
    @tip = Tip.find(params[:id])
    if @tip.update_attributes(tip_params)
      flash[:success] = 'Tipp gespeichert'
      redirect_to games_path
    else
      render 'edit'
    end
  end

  private

  def tip_params
    params.require(:tip).permit(:home_goals, :away_goals)
  end
end
