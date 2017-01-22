require 'csv'
require 'lda-ruby'
class Song < ActiveRecord::Base
  belongs_to :user
  has_many :survey_actions
  has_many :survey_user, through: :survey_actions, foreign_key: "user_id"
  default_scope -> {order(created_at: :desc)}
  validates :user_id, presence: true
  validates :artist_name, presence: true,length: {maximum: 100 }
  validates :song_name, presence: true,length: {maximum: 100 }
  validates :lyric, presence: true,length: {maximum: 10000 }
  is_impressionable

  def self.search(search)
    where("artist_name ILIKE ? OR song_name ILIKE ? OR lyric ILIKE ?","%#{search}%","%#{search}%","%#{search}%")
  end   
  def self.to_csv
    attributes = %w{id topic_num artist_name song_name lyric user_id video_link song_genre}
    CSV.generate(headers: true) do |csv|
      csv << attributes

      all.each do |user|
        csv << user.attributes.values_at(*attributes)
      end
    end
  end 
  def traingwithlda
    stop_word_list = CSV.read("db/stop_word_list.csv")
    topic_number = []
    id = []
    hash_arr = {}
    corpus = Lda::Corpus.new
    datalyric = Song.select("id,lyric")
    datalyric.each do |ly|
      lyric = ly.lyric
      lyric = lyric.split(/\W+/) #cleaning lyric
      lyric = lyric-stop_word_list
      songdata = Lda::TextDocument.new(corpus,lyric.to_s)
      corpus.add_document(songdata)
    end
    lda = Lda::Lda.new(corpus)
    lda.num_topics = 10
    lda.em('random')
    result_matrix = lda.compute_topic_document_probability # till here is ok.
    result_matrix.each do |number|
      if number[0].nan?
        topic_number << 1
      else
      topic_num = number.max #choosing maxmimun number for item
      topic_num = number.index(topic_num) #topic number.......
      topic_number << topic_num + 1 
      end# arrary index start from 0 so I add 1 for topic number
    end
    #selecting id 
    datalyric.each do |i|
      id << i.id
    end
    # make hash with keys as id and values topicnumber
    hash_arr = Hash[id.zip(topic_number)]
    hash_arr.each do |topic_update|
      topic_number_update = Song.find_by_id(topic_update[0]) # key value
      topic_number_update.topic_num = topic_update[1] # values as data
      topic_number_update.save!
    end
  end
end
