class CreatePlays < ActiveRecord::Migration[6.0]
  def change
    create_table :plays do |t|
      t.datetime   :date
      t.belongs_to :game

      t.timestamps
    end
  end
end
