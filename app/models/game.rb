class Game < ApplicationRecord
  CLASS_MAPPING = CollectionMappingService::GAME_ATTRS
  include BggBacked

  scope :owned,        -> { where(own: true) }
  scope :wishlist,     -> { where(wishlist: true) }
  scope :preordered,   -> { where(preordered: true) }
  scope :for_trade,    -> { where(for_trade: true) }
  scope :prevowned,    -> { where(prevowned: true) }
  scope :must_have,    -> { where(wishlist: true, wishlist_priority: 1) }
  scope :love_to_have, -> { where(wishlist: true, wishlist_priority: 2) }
  scope :like_to_have, -> { where(wishlist: true, wishlist_priority: 3) }
  scope :considering,  -> { where(wishlist: true, wishlist_priority: 4) }
  scope :dont_want,    -> { where(wishlist: true, wishlist_priority: 5) }
  scope :want_to_play, -> { where(wanttoplay: true) }
end
