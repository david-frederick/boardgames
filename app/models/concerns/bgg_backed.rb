module BggBacked
  extend ActiveSupport::Concern

  def bgg_thing_data
    BggService.new.thing_data(bgg_id)
  end

  module ClassMethods

    def upsert_from_api_obj!(api_obj)
      thing = self.find_or_initialize_by(bgg_id: api_obj['@objectid'])
      self::CLASS_MAPPING.map{ |attr_obj| attr_obj[:attr] }.each do |attr|
        thing.send(:"#{attr}=", api_obj[attr])
      end
      thing.save!
    rescue ActiveRecord::RecordInvalid => e
      ap e.message
      puts e.backtrace
      ap api_obj
    end
  end
end
