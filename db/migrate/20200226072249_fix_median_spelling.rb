class FixMedianSpelling < ActiveRecord::Migration[6.0]
  def change
    rename_column :games, :mediam, :median
  end
end
