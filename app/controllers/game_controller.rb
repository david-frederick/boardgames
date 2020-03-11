class GameController < ApplicationController
  def index
    @games = Game.all.decorate
  end

  def show
    @game = Game.find(params[:id]).decorate
    @expansions = ExpansionDecorator.decorate_collection(@game.expansions)
  end

  def preorders
    @games = Game.preordered.decorate
  end

  def collection
    @games = Game.owned.decorate
  end

  def wishlist
    @games = Game.wishlist.decorate
  end

  def for_trade
    @games = Game.for_trade.decorate
  end

  def prev_owned
    @games = Game.prevowned.decorate
  end
end
