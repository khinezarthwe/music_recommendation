#group by Song Genre
require 'genre_recommender'
class GenreBasedRecommendWorker
  include Sidekiq::Worker
  def perform(userid)
    hash_arr       = {}
    songs_by_group = {}
    recommend_song = {}
    songs          = Song.all
    rem_userid     = User.pluck(:id)
    # select the current user_id from impression table
    # please modifed this code again
    rem_userid.each do |record_id|
      hash_arr[record_id] = Impression.where(:user_id => record_id).uniq.pluck(:impressionable_id)
    end
    recommender = GenreRecommender.new
    recommender.clean!
    hash_arr.each do |user_num,song_id|
      recommender.add_to_matrix!(:gusers,user_num.to_s,song_id.map(&:to_s))
    end
    songs_by_group = songs.group_by{|s| s.song_genre}
    song_genre = songs_by_group.keys
    song_group = songs_by_group.map {|k, v| v.map {|i|i.id} }
    songs_by_group = Hash[song_genre.zip song_group]
    songs_by_group.each do |k,v|
      recommender.add_to_matrix!(:genre_groups,k.to_s,v.map(&:to_s))
    end
    recommend_song = recommender.predictions_for(userid, matrix_label: :gusers, with_scores: true)
    recommend_song = recommend_song.first(20).to_h
    existing_genre_recommendations = GenreBasedRecommendation.where(:user_id=>userid)
    # already_member = GenreBasedRecommendation.where(:user_id=>userid)
    # if already_member.blank? # create new recommend .nil ???? .blank???
    #   recommend_song.each do |rem_song|
    #     a = GenreBasedRecommendation.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
    #     a.save!
    #   end
    # else
    #save the new one and delete the old one
    #GenreBasedRecommendation.where(:user_id=>userid).delete_all
    GenreBasedRecommendation.where(:user_id=>userid).delete_all unless existing_genre_recommendations.empty?
    recommend_song.each do |rem_song|
      a = GenreBasedRecommendation.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
      a.save!
    end
    # end
  end
  #recommender.add_to_matrix!(:groups,"group-1","s-1", "s-2","s-5")
  #recommender.predictions_for("user-1", matrix_label: :users,with_scores: true)
end
