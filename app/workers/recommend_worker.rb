require 'myrecommender'
class RecommendWorker
  include Sidekiq::Worker
  def perform(userid)
    hash_arr = {}
    songs_by_group = {}
    recommend_song = {}
    songs = Song.all
    rem_userid = User.pluck(:id)
    # select the current user_id from impression table
    # please modifed this code again
    rem_userid.each do |record_id|
      hash_arr[record_id] = Impression.where(:user_id => record_id).uniq.pluck(:impressionable_id)
    end
    recommender = CourseRecommender.new
    hash_arr.each do |user_num,song_id|
      recommender.add_to_matrix!(:users,user_num.to_s,song_id.map(&:to_s))
    end
    songs_by_group = songs.group_by{|s| s.topic_num}
    topic_num = songs_by_group.keys
    song_group = songs_by_group.map {|k, v| v.map {|i|i.id} }
    songs_by_group = Hash[topic_num.zip song_group]
    songs_by_group.each do |k,v|
      recommender.add_to_matrix!(:groups,k.to_s,v.to_s)
    end
   recommend_song = recommender.predictions_for(userid,matrix_label: :users,with_scores: true)
   recommend_song = recommend_song.first(10).to_h
    already_member = TempRecommender.where(:user_id=>userid)
    if already_member.blank? # create new recommend .nil ???? .blank???
      recommend_song.each do |rem_song|
        a = TempRecommender.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
        a.save!
      end
    else
      #save the new one and delete the old one
      TempRecommender.where(:user_id=>userid).delete_all
      recommend_song.each do |rem_song|
        a = TempRecommender.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
        a.save!
      end
    end
  end
  #recommender.add_to_matrix!(:groups,"group-1","s-1", "s-2","s-5")
  #recommender.predictions_for("user-1", matrix_label: :users,with_scores: true)
end