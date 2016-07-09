class AddVideolinkToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :video_link, :string
  end
end
