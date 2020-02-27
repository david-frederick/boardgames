module BggBacked
  extend ActiveSupport::Concern

  def bgg_thing_data
    BggService.new.thing_data(bgg_id)
  end

  module ClassMethods

    def upsert_from_api_obj!(api_obj)
      game = self.find_or_initialize_by(bgg_id: api_obj['@objectid'])
      self::CLASS_MAPPING.map{ |attr_obj| attr_obj[:attr] }.each do |attr|
        game.send(:"#{attr}=", api_obj[attr])
      end
      game.save!
    end
  end
end
