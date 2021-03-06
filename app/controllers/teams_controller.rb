class TeamsController < ApplicationController
  before_action :logged_in_user, only: [:index]

  def index
    @teams = Team.paginate(page: params[:page])
  end

  def show
    @team = Team.find(params[:id])
  end
end
