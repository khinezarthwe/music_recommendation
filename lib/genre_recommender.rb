class GenreRecommender
  include Predictor::Base
  input_matrix :gusers
  input_matrix :genre_groups
end
