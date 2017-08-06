class GamesController < ApplicationController
  before_action :logged_in_user, only: [:index, :show]
  before_action :admin_user,     only: [:new, :edit]

  def index
    @games = Game.paginate(page: params[:page], per_page: 10).order('id DESC')
    @user = current_user
  end

  def show
    @game = Game.find(params[:id])
    @tips = @game.tips.all
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      User.all.each do |user|
        Tip.create(game_id: @game.id, user_id: user.id)
      end
      flash[:info] = 'Das Spiel wurde erstellt'
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
      flash[:success] = 'Spiel geändert'
      redirect_to games_path
    else
      render 'edit'
    end
  end

  private

    def game_params
      params.require(:game).permit(:game_number,
                                   :game_date,
                                   :home_team_id,
                                   :away_team_id,
                                   :home_goals,
                                   :away_goals)
    end
end
