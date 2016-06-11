require 'test_helper'

class AllsongTest < ActiveSupport::TestCase
  def setup
  	@song = Allsong.new(lastfm_userid:"user_000001",timestamp:"2009-05-03T15:48:25Z",artist_id:"001",artist_name:"Juu",traid:"00a",trackname:"Moe")
  end
  test "should be valid" do
    assert @song.valid?
  end
end
