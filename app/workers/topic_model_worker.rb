require 'myrecommender'
class TopicModelWorker
  include Sidekiq::Worker
  def perform(userid)
    hash_arr = {}
    songs_by_topic = {}
    recommend_song = {}
    songs = Song.all
    rem_userid = User.pluck(:id)
    # select the current user_id from impression table
    # please modifed this code again
    rem_userid.each do |record_id|
      hash_arr[record_id] = Impression.where(:user_id => record_id,:action_name => 'show').uniq.pluck(:impressionable_id)
    end
    recommender = CourseRecommender.new
    recommender.clean!
    hash_arr.each do |user_num,song_id|
      recommender.add_to_matrix!(:users ,user_num.to_s, song_id.map(&:to_s))
    end
    songs_by_topic = songs.group_by{ |s| s.topic_num  }
    topic_num  = songs_by_topic.keys
    song_group_topic = songs_by_topic.map {|k, v| v.map {|i|i.id} }
    songs_by_topic = Hash[topic_num.zip song_group_topic]
    songs_by_topic.each do |k,v|
      recommender.add_to_matrix!(:groups, k.to_s, v.map(&:to_s))
    end

    topic_recommendations = recommender.predictions_for(userid,matrix_label: :users,with_scores: true)
    
    topic_recommendations = topic_recommendations.first(10).to_h

    existing_topic_recommendations = TempRecommender.where(:user_id=>userid)
    
    TempRecommender.where(:user_id=>userid).delete_all unless existing_topic_recommendations.empty?
   
    topic_recommendations.each do |rem_song|
      a = TempRecommender.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
      a.save!
    end
  end
  #recommender.add_to_matrix!(:groups,"group-1","s-1", "s-2","s-5")
  #recommender.predictions_for("user-1", matrix_label: :users,with_scores: true)
 end

