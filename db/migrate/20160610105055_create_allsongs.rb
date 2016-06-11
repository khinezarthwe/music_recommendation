class CreateAllsongs < ActiveRecord::Migration
  def change
    create_table :allsongs do |t|
      t.string :lastfm_userid
      t.datetime :timestamp
      t.string :artist_id
      t.string :artist_name
      t.string :traid
      t.string :trackname

      t.timestamps null: false
    end
  end
end
