require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  def setup
  	@song = songs(:songone)
  end

 test "should redirect create when not logged in" do
 	assert_no_difference 'Song.count' do
 		post :create, song: { topic_num:1,artist_name:"Justin Biber",song_name:"Love Yourself",lyric:"For the time"}
 	end
 	assert_redirected_to login_url
 end
 test "should redirect destroy when not logged in" do
 	assert_no_difference'Song.count' do
 		delete :destroy, id: @song
 	end
 	assert_redirected_to login_url
 end 
 test "should redirect destroy for wrong song" do
 	log_in_as (users(:khinezarthwe))
 	song = songs(:songone)
 	assert_no_difference 'Song.count' do
 		delete :destroy, id: song
 	end
 	assert_redirected_to root_url
 end
end 
