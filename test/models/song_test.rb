require 'test_helper'

class SongTest < ActiveSupport::TestCase
  def setup
    @user = users(:khinezarthwe)
    @song = @user.songs.build(topic_num:1,artist_name:"Justin Biber",song_name:"Love Yourself",lyric:"For the time")
    #@song = Song.new(topic_num:1,artist_name:"Justin Biber",song_name:"Love Yourself",lyric:"For the time",user_id:@user_id)
  end

  test "should be valid" do
    assert @song.valid?
  end

  test "user id should be present" do
    @song.user_id = nil
    assert_not @song.valid?
  end

  test "artist_name should be present" do
    @song.artist_name = " "
    assert_not @song.valid?
  end
  test "song name should be present" do
    @song.song_name = " "
    assert_not @song.valid?
  end
  test "song lyric should be present" do
    @song.lyric = " "
    assert_not @song.valid?
  end
  test "aritst_name should be at most 100" do
    @song.artist_name = "a"*101
    assert_not @song.valid?
  end
  test "song_name should be at most 100" do
    @song.song_name = "a"*101
    assert_not @song.valid?
  end
  test "lyric should be at most 10000" do
    @song.lyric = "a"*10001
    assert_not @song.valid?
  end
  test "order should be most recent first" do
  	assert_equal songs(:songtwo),Song.first
  end
end
