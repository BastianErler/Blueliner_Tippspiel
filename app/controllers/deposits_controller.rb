class DepositsController < ApplicationController
  before_action :logged_in_user, only: [:index]
  before_action :admin_user,     only: [:new]

  def index
    @deposits = Deposit.paginate(page: params[:page], per_page: 10).order('id DESC')
  end

  def show
    @deposits = Deposit.find(params[:id])
  end

  def new
    @user = User.find(params[:format])
    @deposit = Deposit.new(user_id: params[:format], creater_id: current_user.id)
  end

  def create
    @deposit = Deposit.new(deposit_params)
    if @deposit.save
      flash[:info] = 'Die Einzahlung war erfolgreich'
      redirect_to users_path
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

    def deposit_params
      params.require(:deposit).permit(:user_id, :creater_id, :comment, :amount)
    end
end
