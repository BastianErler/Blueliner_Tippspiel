class GamesController < ApplicationController
  def index
    @games = Game.paginate(page: params[:page])
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new()
  end

  def create
    @game = Game.new(game_params)
    # binding.pry
    if @game.save
      flash[:info] = "Das Spiel wurde erstellt"
      redirect_to games_path
    else
      render 'new'
    end
  end

  def edit
    @game = Game.find(params[:id])
  end

  def update
    @game = Game.find(params[:id])
    if @game.update_attributes(game_params)
      binding.pry
      flash[:success] = "Spiel geändert"
      redirect_to games_path
    else
      render 'edit'
    end
  end

  private

    def game_params
      params.require(:game).permit(:game_number, :game_date, :home_team_id, :away_team_id)
    end
end
