class SongsController < ApplicationController
	before_action :logged_in_user, only:[:create,:destroy]
	before_action :correct_user, only: :destroy

	def create
		@song = current_user.songs.build(song_params)
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

	def show
		@song = Song.find(params[:id])
	end

	private 
	def song_params
		params.require(:song).permit(:topic_num,:artist_name,:song_name,:lyric)
	end
	def correct_user
		@song = current_user.songs.find_by(id: params[:id])
		redirect_to root_url if @song.nil?
	end
end
