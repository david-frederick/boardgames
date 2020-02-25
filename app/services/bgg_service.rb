class BggService
  API_PATH = 'https://www.boardgamegeek.com/xmlapi2'.freeze
  USERNAME = 'warder57'.freeze
  USER_ATTRS = %w{ firstname lastname yearregistered lastlogin traderating marketrating }
  COLLECTION_ATTRS = %w{ @objectid name yearpublished image thumbnail stats/@minplayers stats/@maxplayers
    stats/@minplaytime stats/@maxplaytime stats/@playingtime stats/@numowned average/@value numplays wishlistcomment
    status/@own status/@prevowned status/@fortrade status/@want status/@wanttoplay status/@wanttobuy status/@wishlist
    status/@wishlistpriority status/@preordered status/@lastmodified rating//usersrated/@value rating//average/@value
    rating//ranks//rank[name='boardgame']/@value rating//ranks//rank[name='boardgame']/@bayesaverage rating//median/@value
    rating//stddev/@value rating//bayesaverage/@value
  }

  def user_data
    url      = URI.parse("#{API_PATH}/user?name=#{USERNAME}")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    USER_ATTRS.inject({}){ |h, attr| h[attr] = data.xpath("//#{attr}")[0].values[0]; h }
  end

  def sync_collection_data
    url      = URI.parse("#{API_PATH}/collection?username=#{USERNAME}&stats=1")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    items    = data.xpath("//items//item")
    items.each do |item|
      resp_item = COLLECTION_ATTRS.inject({}) { |h, attr| h[attr] = item.css(attr).first&.content; h }
      Game.upsert_from_api_obj!(resp_item)
    end
  end

  def http_request(url)
    req = Net::HTTP::Get.new url
    res = Net::HTTP.start(url.host, url.port,
        :use_ssl => url.scheme == 'https') {|http| http.request req}
    res.body
  end
end
