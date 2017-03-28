class UsersController < ApplicationController
  before_action :logged_in_user,only: [:index,:edit,:update,:destroy]
  before_action :correct_user, only: [:edit,:update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page],per_page: 10) 
    respond_to do |format|
      format.html
      format.csv{ send_data @users.to_csv, filename:"user-#{Date.today}.csv"}
    end
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @user_songs = @user.songs.paginate(page: params[:page],per_page: 10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  private
    
  #Confirms an admin user
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  def user_params
    params.require(:user).permit(:name,:email,:password,:password_confirmation,
                                 :age,:gender,:occupation)
  end
  #confrim a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
