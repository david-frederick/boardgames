class BggService
  API_PATH = 'https://www.boardgamegeek.com/xmlapi2'.freeze
  USERNAME = 'warder57'.freeze

  def user_data
    url      = URI.parse("#{API_PATH}/user?name=#{USERNAME}")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    CollectionMappingService::USER_ATTRS.inject({}){ |h, attr| h[attr] = data.xpath("//#{attr}")[0].values[0]; h }
  end

  def sync_collection_data
    sync_game_data
    sync_expansion_data
    sync_expansion_links
  end

  def sync_game_data
    game_data.each do |game|
      Game.upsert_from_api_obj!(game)
    end
  end

  def game_data
    items = unparsed_game_data
    items.map do |item|
      CollectionMappingService::GAME_ATTRS.inject({}) { |h, attr| h[attr[:attr]] = item.css(attr[:xpath]).first&.content; h }
    end
  end

  # keeping so I can manually see the api object
  def unparsed_game_data
    url      = URI.parse("#{API_PATH}/collection?username=#{USERNAME}&stats=1&showprivate=1&excludesubtype=boardgameexpansion")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    data.xpath("//items//item")
  end

  def sync_expansion_data
    expansion_data.each do |exp|
      Expansion.upsert_from_api_obj!(exp)
    end
  end

  def expansion_data
    items = unparsed_expansion_data
    items.map do |item|
      CollectionMappingService::EXP_ATTRS.inject({}) { |h, attr| h[attr[:attr]] = item.css(attr[:xpath]).first&.content; h }
    end
  end

  # keeping so I can manually see the api object
  def unparsed_expansion_data
    url      = URI.parse("#{API_PATH}/collection?username=#{USERNAME}&stats=1&showprivate=1&subtype=boardgameexpansion")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    data.xpath("//items//item")
  end

  def sync_expansion_links
    Expansion.without_association.each do |exp|
      ap exp.name
      data = thing_data(exp.bgg_id)
      game_bgg_ids = data.css("//link[type='boardgameexpansion']/@id").map(&:value)
      ap game_bgg_ids
      game_bgg_ids.each do |game_id|
        game = Game.where(bgg_id: game_id).first
        next unless game
        exp.game = game
        exp.save!
      end
      sleep(0.5)
    end
  end

  def thing_data(bgg_id)
    unparsed_thing_data(bgg_id)
  end

  def unparsed_thing_data(bgg_id)
    url = URI.parse("#{API_PATH}/thing?id=#{bgg_id}")
    response = http_request(url)
    Nokogiri::XML(response)
  end

  def http_request(url)
    req = Net::HTTP::Get.new url
    res = Net::HTTP.start(url.host, url.port,
        :use_ssl => url.scheme == 'https') {|http| http.request req}
    res.body
  end
end
