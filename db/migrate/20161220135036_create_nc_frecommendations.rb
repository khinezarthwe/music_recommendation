class CreateNcFrecommendations < ActiveRecord::Migration
  def change
    create_table :nc_frecommendations do |t|
      t.integer :user_id
      t.integer :song_id
      t.decimal :recommend_value

      t.timestamps null: false
    end
  end
end
