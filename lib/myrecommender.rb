class CourseRecommender
  include Predictor::Base
  input_matrix :users
  input_matrix :groups
end
#recommender = CourseRecommender.new
#recommender.add_to_matrix!(:users,"user-1", ["s-1","s-3","s-4"])
#recommender.add_to_matrix!(:users,"user-2", "s-1","s-2","s-4","s-5")
#recommender.add_to_matrix!(:users,"user-3", "s-1","s-2","s-4","s-5")
#recommender.add_to_matrix!(:users,"user-4", "s-1","s-2","s-3")
#recommender.add_to_matrix!(:users,"user-5","s-6")
#recommender.add_to_matrix!(:groups,"group-1","s-1", "s-2","s-5")
#recommender.add_to_matrix!(:groups,"group-2","s-3","s-4","s-6")
#recommender.similarities_for("s-1",with_scores: true)
#recommender.predictions_for("user-1", matrix_label: :users,with_scores: true)



#SELECT DISTINCT impressionable_id FROM impressions WHERE user_id=1;
#Impression.where(:user_id => 1).uniq.pluck(:impressionable_id)
#User.pluck(:id)
#hash_arr[1].map(&:to_s)
#songs = Song.all
#songs.group_by {|s| s.topic_num }.map {|k, v| v.map {|i|i.id,i.topic_num}}
#s.group_by{|s| s.topic_num}