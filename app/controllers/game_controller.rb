class GameController < ApplicationController
  def index
    @games = Game.all.decorate
  end

  def show
    @game = Game.find(params[:id]).decorate
    @expansions = ExpansionDecorator.decorate_collection(@game.expansions)
  end
end
