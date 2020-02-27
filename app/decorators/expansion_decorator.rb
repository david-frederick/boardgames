class ExpansionDecorator < Draper::Decorator
  delegate_all

  def bgg_link
    "https://boardgamegeek.com/boardgame/#{bgg_id}"
  end
end
