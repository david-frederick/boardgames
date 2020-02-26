class CorrectExpansions < ActiveRecord::Migration[6.0]
  def change
    add_column :expansions, :bgg_id, :string, unique: true, null: false
    add_column :expansions, :name, :string
  end
end
