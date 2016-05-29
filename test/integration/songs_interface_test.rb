require 'test_helper'

class SongsInterfaceTest < ActionDispatch::IntegrationTest
  def setup
  	@user = users(:khinezar)
  end
  test "song interface" do
  	log_in_as(@user)
  	get root_path
  	#invalid submission
  	assert_no_difference 'Song.count' do
  		post songs_path,song: {lyric:""}
  	end
  	#valid submission
  	assert_difference 'Song.count',1 do
  		post songs_path,song: {topic_num:1,artist_name:"Justin Biber",song_name:"Love Yourself",lyric:"For the time"}
  	end
  	follow_redirect!
  	#Delete a post
  	assert_select'a',text:'delete',count:0
  	first_song = @user.songs.paginate(page:1).first
  	assert_difference 'Song.count',-1 do
  		delete song_path(first_song)
  	end
  	#Visit a differnt user
  	get user_path(users(:khinezarthwe))
  	assert_select 'a',text:'delete',count:0
  end
end
