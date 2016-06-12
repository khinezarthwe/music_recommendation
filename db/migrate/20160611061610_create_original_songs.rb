class CreateOriginalSongs < ActiveRecord::Migration
  def change
    create_table :original_songs do |t|
      t.string :traid
      t.string :track_name
      t.string :artist_id
      t.string :artist_name

      t.timestamps null: false
    end
  end
end
