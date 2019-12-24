class UsersController < ApplicationController
  before_action :signed_in_user,
	  only: [:index, :edit, :update, :destroy, :following, :followers] 
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :restrict_regist, only: [:new, :create]

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def edit
    # with addition of correct user now we skip this
    # @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    unless current_user?(user)
      user.destroy
      flash[:success] = "User deleted"
    end
    redirect_to users_url
  end

  def update
    # with addition of correct user now we skip this
    # @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample app!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    #before filters


    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

    def restrict_regist
      redirect_to root_url, notice: "You are already registered" if signed_in?
    end
end
