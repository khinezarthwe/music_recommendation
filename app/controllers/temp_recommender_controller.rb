class TempRecommenderController < ApplicationController
  
  def new
  end

  def agree
    @song_id = params[:song_id]
    @user_id = params[:user_id]
    @agreed = params[:agreed]
    @survey_action = SurveyAction.new
    @survey_action.user_id  = @user_id
    @survey_action.song_id  = @song_id
    @survey_action.agreed   = @agreed
    survey_song_topic = TempRecommender.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    @survey_song_topic_hash = Hash["topic" => survey_song_topic]
    @survey_action.topic    = @survey_song_topic_hash["topic"].include?@song_id.to_i
    
    survey_song_genre = GenreBasedRecommendation.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    @survey_song_genre_hash = Hash["genre" => survey_song_genre]
    @survey_action.genre    = @survey_song_genre_hash["genre"].include?@song_id.to_i

    survey_song_ncf = NcFrecommendation.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    @survey_song_ncf_hash = Hash["ncf" => survey_song_ncf]
    @survey_action.ncf      = @survey_song_ncf_hash["ncf"].include?@song_id.to_i


    @survey_action.save!
    respond_to do|format|
      format.html
      format.js
    end
  end

  def survey
    survey_song = surveyselectdata
    @survey_song_for_eva = Song.where(:id=>survey_song).pluck(:video_link,:id)
    respond_to do|format|
      format.html
      format.js 
    end
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

  def surveyselectdata
    survey_song_topic = survey_song_genre = survey_song_ncf = []
    #@survey_song_topic_hash = @survey_song_genre_hash = @survey_song_ncf_hash = {}

    survey_song_topic = TempRecommender.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    #@survey_song_topic_hash = Hash["topic" => survey_song_topic]
    
    survey_song_genre = GenreBasedRecommendation.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    #@survey_song_genre_hash = Hash["genre" => survey_song_genre]

    survey_song_ncf = NcFrecommendation.select('song_id').where(:user_id=>current_user.id).pluck(:song_id)
    #@survey_song_ncf_hash = Hash["ncf" => survey_song_ncf]

    @survey_song = survey_song_topic+survey_song_genre+survey_song_ncf
  end 
end
