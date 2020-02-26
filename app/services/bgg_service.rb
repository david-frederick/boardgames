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

  # TODO:
  # showprivate=1 will get you private info such as aquisition_date
  def game_data
    items = unparsed_game_data
    items.map do |item|
      CollectionMappingService::GAME_ATTRS.inject({}) { |h, attr| h[attr[:attr]] = item.css(attr[:xpath]).first&.content; h }
    end
  end

  # keeping so I can manually see the api object
  def unparsed_game_data
    url      = URI.parse("#{API_PATH}/collection?username=#{USERNAME}&stats=1&excludesubtype=boardgameexpansion")
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
    url      = URI.parse("#{API_PATH}/collection?username=#{USERNAME}&stats=1&subtype=boardgameexpansion")
    response = http_request(url)
    data     = Nokogiri::XML(response)
    data.xpath("//items//item")
  end

  # TODO:
  # decided: only concern myself with expansions in my collection
  def sync_expansion_links
    Expansion.all.each do |exp|
      
    end
  end

  def http_request(url)
    req = Net::HTTP::Get.new url
    res = Net::HTTP.start(url.host, url.port,
        :use_ssl => url.scheme == 'https') {|http| http.request req}
    res.body
  end
end
