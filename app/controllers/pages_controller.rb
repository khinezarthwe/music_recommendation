class PagesController < ApplicationController
  def home
    @song = current_user.songs.build if logged_in?
  end

  def help
  end
  def about
  	
  end
  def contact
  	
  end
end
