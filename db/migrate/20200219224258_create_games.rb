class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games do |t|
      t.string   :bgg_id, unique: true, null: false
      t.string   :name
      t.string   :year_published
      t.string   :image
      t.string   :thumbnail
      t.integer  :min_players
      t.integer  :max_players
      t.integer  :min_playtime
      t.integer  :max_playtime
      t.integer  :playingtime
      t.integer  :num_owned
      t.integer  :avg_bgg_rating
      t.integer  :numplays
      t.text     :wishlist_comment
      t.boolean  :own
      t.boolean  :prevowned
      t.boolean  :fortrade
      t.boolean  :want
      t.boolean  :wanttoplay
      t.boolean  :wanttobuy
      t.boolean  :wishlist
      t.integer  :wishlist_priority
      t.boolean  :preordered
      t.datetime :last_modified
      t.integer  :num_bgg_ratings
      t.integer  :bgg_rank
      t.string   :bayes_avg
      t.string   :mediam
      t.string   :std_dev

      t.timestamps
    end
  end
end
