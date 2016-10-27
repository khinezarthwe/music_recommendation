class CreateGenreBasedRecommendations < ActiveRecord::Migration
  def change
    create_table :genre_based_recommendations do |t|
      t.integer :user_id
      t.integer :song_id
      t.decimal :recommend_value

      t.timestamps null: false
    end
  end
end
