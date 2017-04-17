class TipsController < ApplicationController
  def edit
    @tip = Tip.find_by(game_id: params[:id], user_id: current_user.id)
    @game = Game.find_by(id: params[:id])
    @home_team = Team.find_by(id: @game.home_team_id)
    @away_team = Team.find_by(id: @game.away_team_id)
    if @game.state == 'closed'
      flash[:warning] = 'Spiel geschlossen'
      redirect_to games_path
    end
  end

  def update
    @tip = Tip.find(params[:id])
    if @tip.update_attributes(tip_params)
      flash[:success] = 'Tip gespeichert'
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
