class CollectionMappingService
  EXP_ATTRS = [
    { attr: :bgg_id,            xpath: '@objectid' },
    { attr: :name,              xpath: 'name' },
    { attr: :year_published,    xpath: 'yearpublished' },
    { attr: :image,             xpath: 'image' },
    { attr: :thumbnail,         xpath: 'thumbnail' },
    { attr: :numplays,          xpath: 'numplays' },
    { attr: :wishlist_comment,  xpath: 'wishlistcomment' },
    { attr: :own,               xpath: 'status/@own' },
    { attr: :prevowned,         xpath: 'status/@prevowned' },
    { attr: :fortrade,          xpath: 'status/@fortrade' },
    { attr: :want,              xpath: 'status/@want' },
    { attr: :wanttoplay,        xpath: 'status/@wanttoplay' },
    { attr: :wanttobuy,         xpath: 'status/@wanttobuy' },
    { attr: :wishlist,          xpath: 'status/@wishlist' },
    { attr: :wishlist_priority, xpath: 'status/@wishlistpriority' },
    { attr: :preordered,        xpath: 'status/@preordered' },
    { attr: :last_modified,     xpath: 'status/@lastmodified' },
    { attr: :num_bgg_ratings,   xpath: 'rating//usersrated/@value' },
    { attr: :avg_bgg_rating,    xpath: 'rating//average/@value' }
  ]

  GAME_ATTRS = EXP_ATTRS + [
    { attr: :min_players,  xpath: 'stats/@minplayers' },
    { attr: :max_players,  xpath: 'stats/@maxplayers' },
    { attr: :min_playtime, xpath: 'stats/@minplaytime' },
    { attr: :max_playtime, xpath: 'stats/@maxplaytime' },
    { attr: :playingtime,  xpath: 'stats/@playingtime' },
    { attr: :num_owned,    xpath: 'stats/@numowned' },
    { attr: :bgg_rank,     xpath: "rating//ranks//rank[name='boardgame']/@value" },
    { attr: :bayes_avg,    xpath: "rating//ranks//rank[name='boardgame']/@bayesaverage" },
    { attr: :median,       xpath: 'rating//median/@value' },
    { attr: :std_dev,      xpath: 'rating//stddev/@value' }
  ]

  USER_ATTRS = %w{ firstname lastname yearregistered lastlogin traderating marketrating }
end
