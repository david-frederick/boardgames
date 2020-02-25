class Game < ApplicationRecord
  def self.upsert_from_api_obj!(api_obj)
    self.where(bgg_id: api_obj['@objectid']).first_or_initialize do |game|
      game.update_attributes(
        bgg_id:            api_obj['@objectid'],
        name:              api_obj['name'],
        year_published:    api_obj['yearpublished'],
        image:             api_obj['image'],
        thumbnail:         api_obj['thumbnail'],
        min_players:       api_obj['stats/@minplayers'],
        max_players:       api_obj['stats/@maxplayers'],
        min_playtime:      api_obj['stats/@minplaytime'],
        max_playtime:      api_obj['stats/@maxplaytime'],
        playingtime:       api_obj['stats/@playingtime'],
        num_owned:         api_obj['stats/@numowned'],
        avg_bgg_rating:    api_obj['average/@value'],
        numplays:          api_obj['numplays'],
        wishlist_comment:  api_obj['wishlistcomment'],
        own:               api_obj['status/@own'],
        prevowned:         api_obj['status/@prevowned'],
        fortrade:          api_obj['status/@fortrade'],
        want:              api_obj['status/@want'],
        wanttoplay:        api_obj['status/@wanttoplay'],
        wanttobuy:         api_obj['status/@wanttobuy'],
        wishlist:          api_obj['status/@wishlist'],
        wishlist_priority: api_obj['status/@wishlistpriority'],
        preordered:        api_obj['status/@preordered'],
        last_modified:     api_obj['status/@lastmodified'],
        num_bgg_ratings:   api_obj['rating//usersrated/@value'],
        bgg_rank:          api_obj["rating//ranks//rank[name='boardgame']/@value"],
        bayes_avg:         api_obj["rating//ranks//rank[name='boardgame']/@bayesaverage"],
        mediam:            api_obj['rating//median/@value'],
        std_dev:           api_obj['rating//stddev/@value']
      )
      game.save!
    end
  end
end
