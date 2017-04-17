# StaticPagesController
class StaticPagesController < ApplicationController
  def home
    @game = Game.where(current: true).first
  end

  def help; end

  def rules; end
end
