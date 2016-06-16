class Song < ActiveRecord::Base
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :artist_name, presence: true,length: {maximum: 100 }
  validates :song_name, presence: true,length: {maximum: 100 }
  validates :lyric, presence: true,length: {maximum: 10000 }

  def self.search(search)
		where("artist_name LIKE ? OR song_name LIKE ? OR lyric LIKE ?","%#{search}%","%#{search}%","%#{search}%")
	end
end
