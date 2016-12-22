#normal item*item collaborative filtering method
require 'normalcfrecommender'
class Normalcf
  def perform(userid)
    hash_arr = {}
    recommend_song = {}
    songs = Song.all
    rem_userid = User.pluck(:id)
    # select the current user_id from impression table
    # please modifed this code again
    rem_userid.each do |record_id|
      hash_arr[record_id] = Impression.where(:user_id => record_id).uniq.pluck(:impressionable_id)
    end
    nf_recommender = Ncf_Recommender.new
    nf_recommender.clean!
    hash_arr.each do |user_num,song_id|
      nf_recommender.add_to_matrix!(:ncf_users, user_num.to_s, song_id.map(&:to_s))
    end

    nf_recommendations = nf_recommender.predictions_for(userid, matrix_label: :ncf_users, with_scores: true)
    nf_recommendations = nf_recommendations.first(20).to_h
    
    nf_recommendations = NcFrecommendation.where(:user_id=>userid)
    NcFrecommendation.where(:user_id=>userid).delete_all unless nf_recommendations.empty?

    nf_recommendations.each do |rem_song|
      a = NcFrecommendation.new(user_id:userid,song_id:rem_song[0],recommend_value:rem_song[1])
      a.save!
    end
    p nf_recommendations
  end
end


