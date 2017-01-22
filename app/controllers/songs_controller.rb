class SongsController < ApplicationController
  before_action :logged_in_user, only:[:create,:destroy]
  before_action :correct_user, only: [:edit,:update]
  impressionist :actions => [:show]

  def index
    @songs = Song.paginate(page: params[:page])
    respond_to do |format|
      format.html
      format.csv{ send_data @songs.to_csv, filename:"song-#{Date.today}.csv"}
    end
  end

  def create
    @song = current_user.songs.build(song_params)
    LdaWorker.perform_async(@song)
    if @song.save
      flash[:success] = "Song created"
      redirect_to root_url
    else
      render 'pages/home'
    end
  end
  
  def destroy
    @song.destroy
    flash[:success] = "Song deleted"
    redirect_to request.referrer || root_url
  end
  def edit
    @song = Song.find(params[:id])
  end
  def update
     @song = Song.find(params[:id])
    if @song.update_attributes(song_params)
      flash[:success] = "Song Information was updated"
      redirect_to @song
    else
      render 'edit'
    end
  end

  def show
    @song = Song.find(params[:id])
  end

  def find
    if params[:search]
      @songs = Song.search(params[:search]).order("created_at DESC")
      @count = @songs.paginate(page: params[:page])
    else
      @songs = Song.all.order('created_at DESC')
    end
  end

  private
  def song_params
    params.require(:song).permit(:topic_num,:artist_name,:song_name,:lyric,:video_link,:song_genre)
  end
  def correct_user
    @song = current_user.songs.find_by(id: params[:id])
    redirect_to root_url if @song.nil?
  end
end
