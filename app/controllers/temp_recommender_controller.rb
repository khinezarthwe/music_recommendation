class TempRecommenderController < ApplicationController
  def new
  end
  def recommend_song
    arr_songs = []
    genre_songs = []
    nf_songs = []
    #a = RecommendWorker.new
    #a.perform(current_user.id)
    a = TopicModelWorker.new
    a.perform(current_user.id)
    #TopicModelWorker.perform_async(current_user.id)
    b = GenreBasedRecommendWorker.new
    b.perform(current_user.id)
    #GenreBasedRecommendWorker.perform_async(current_user.id)
    c = Normalcf.new
    c.perform(current_user.id)
    # Adding normal collaborative filtering result
    temp_recommend_song = TempRecommender.where(:user_id=>current_user.id)
    if temp_recommend_song.nil?
      @recommend_song = []
    else
      temp_recommend_song.each do |song|
        arr_songs << song.song_id
      end
      @recommend_song = Song.where(:id=>arr_songs)
    end

    genre_recommend_song = GenreBasedRecommendation.where(:user_id=>current_user.id)

    if genre_recommend_song.nil?
      @genre_recommend_song = []
    else
      genre_recommend_song.each do |song|
        genre_songs << song.song_id
      end
      @genre_recommend_song = Song.where(:id=>genre_songs)
    end
    nf_recommend_song = NcFrecommendation.where(:user_id=>current_user.id)
    if nf_recommend_song.nil?
      @nf_recommend_song = []
    else
      nf_recommend_song.each do |song|
        nf_songs << song.song_id
      end
      @nf_recommend_song = Song.where(:id=>nf_songs)
    end
    respond_to do|format|
      format.html
      format.js
    end
  end
end
