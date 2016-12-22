# for normal collaborative filtering
class Ncf_Recommender
  include Predictor::Base
  input_matrix :ncf_users
end
# recommender = Ncf_Recommender.new
# recommender.add_to_matrix!(:ncf_users,"user-1", "s-1","s-3","s-4")
# recommender.add_to_matrix!(:ncf_users,"user-2", "s-1","s-2","s-4","s-5")
# recommender.add_to_matrix!(:ncf_users,"user-3", "s-1","s-2","s-4","s-5")
# recommender.add_to_matrix!(:ncf_users,"user-4", "s-1","s-2","s-3")
# recommender.add_to_matrix!(:ncf_users,"user-5")
# recommender.add_to_matrix!(:ncf_users,"user-6")

# recommender.add_to_matrix!(:groups,"group-1","s-1", "s-2","s-3","s-4","s-5","s-6")

# recommender.similarities_for("s-1",with_scores: true)
# recommender.predictions_for("user-6", matrix_label: :ncf_users,with_scores: true)