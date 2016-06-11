class AddTraidToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :traid, :string
  end
end
