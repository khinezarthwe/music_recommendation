class CreateTempRecommenders < ActiveRecord::Migration
  def change
    create_table :temp_recommenders do |t|
      t.integer :user_id
      t.integer :song_id
      t.decimal :recommend_value

      t.timestamps null: false
    end
  end
end
