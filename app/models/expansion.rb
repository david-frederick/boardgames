class Expansion < ApplicationRecord
  CLASS_MAPPING = CollectionMappingService::EXP_ATTRS
  include BggBacked

  belongs_to :game
end
