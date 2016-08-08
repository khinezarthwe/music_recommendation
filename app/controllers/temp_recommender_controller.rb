class TempRecommenderController < ApplicationController
  def new
  end
  def recommend_song
  	arr_song = []
    RecommendWorker.perform_async(current_user.id)
    temp_recommend_song = TempRecommender.where(:user_id=>current_user.id)
    if temp_recommend_song.nil?
    	@recommend_song = nil
    else
      temp_recommend_song.each do |song|
        arr_song << song.song_id
      end
      @recommend_song = Song.find(arr_song)
    end
  end
end
