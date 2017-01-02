class CreateSurveyActions < ActiveRecord::Migration
  def change
    create_table :survey_actions do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :song, index: true, foreign_key: true
      t.boolean :agreed
      t.boolean :topic
      t.boolean :genre
      t.boolean :ncf

      t.timestamps null: false
    end
  end
end
