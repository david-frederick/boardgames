require 'rails_helper'

RSpec.describe Game, type: :model do
  context 'while pulling BGG collection data' do
    let(:api_obj) { { "@objectid"=>"421", "name"=>"1830: Railways & Robber Barons", "yearpublished"=>"1986", "image"=>"https://cf.geekdo-images.com/original/img/cUZaArfHWQol8cYWY_Z4PaMPyC0=/0x0/pic882119.jpg", "thumbnail"=>"https://cf.geekdo-images.com/thumb/img/YDPsVB7gkfTxMaFffjhFNjgY3VU=/fit-in/200x150/pic882119.jpg", "stats/@minplayers"=>"2", "stats/@maxplayers"=>"7", "stats/@minplaytime"=>"180", "stats/@maxplaytime"=>"360", "stats/@playingtime"=>"360", "stats/@numowned"=>"6444",
                      "average/@value"=>"7.87609", "numplays"=>"0", "wishlistcomment"=>"This is supposed.\"\n\nExpected Rating: 9", "status/@own"=>"0", "status/@prevowned"=>"0", "status/@fortrade"=>"0", "status/@want"=>"1", "status/@wanttoplay"=>"0", "status/@wanttobuy"=>"0", "status/@wishlist"=>"1", "status/@wishlistpriority"=>"3", "status/@preordered"=>"0", "status/@lastmodified"=>"2020-02-16 16:49:49", "rating//usersrated/@value"=>"4335", "rating//average/@value"=>"7.87609",
                      "rating//ranks//rank[name='boardgame']/@value"=>"170", "rating//ranks//rank[name='boardgame']/@bayesaverage"=>"7.29696", "rating//median/@value"=>"0", "rating//stddev/@value"=>"1.62494", "rating//bayesaverage/@value"=>"7.29696" } }

    context 'when there is no existing game' do
      it 'creates a new game record' do
        expect(Game.count).to eq 0
        Game.upsert_from_api_obj!(api_obj)
        expect(Game.count).to eq 1
        expect(Game.first.name).to eq '1830: Railways & Robber Barons'
      end
    end

    context 'when there is an existing game' do
      let!(:game) { create(:game, bgg_id: '421', name: 'blah') }

      it 'updates the existing game record' do
        expect(Game.count).to eq 1
        Game.upsert_from_api_obj!(api_obj)
        expect(Game.count).to eq 1
        expect(Game.first.name).to eq '1830: Railways & Robber Barons'
      end
    end
  end
end
