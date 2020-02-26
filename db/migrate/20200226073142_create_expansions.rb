class CreateExpansions < ActiveRecord::Migration[6.0]
  def change
    create_table :expansions do |t|
      t.belongs_to :game
      t.string     :year_published
      t.string     :image
      t.string     :thumbnail
      t.integer    :num_owned
      t.integer    :avg_bgg_rating
      t.integer    :numplays
      t.text       :wishlist_comment
      t.boolean    :own
      t.boolean    :prevowned
      t.boolean    :fortrade
      t.boolean    :want
      t.boolean    :wanttoplay
      t.boolean    :wanttobuy
      t.boolean    :wishlist
      t.integer    :wishlist_priority
      t.boolean    :preordered
      t.datetime   :last_modified
      t.integer    :num_bgg_ratings

      t.timestamps
    end
  end
end
