class UsersController < ApplicationController
  before_action :only_loggedin_users, only: [:index, :edit, :update,
                                                            :destroy, :following, :followers]
  before_action :correct_user, only: [:edit, :update]


  def index
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_url
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    #while showing the User's profile page,show all their microposts too 
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 12)
  end



  def edit
    @user = User.find(params[:id])

  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url
  end

  # method and a assignment for our FOLLOWING page
  def following
    @title = "Following" #intead of using <% provide() %> ew can put title here
    @user = User.find(params[:id]) #get the user ID
    @users = @user.followed_users.paginate(page: params[:page], per_page: 10) #this is shows the following users
    @all_users = @user.followed_users #just assignment to get all the users you FOllOW
    render 'show_follow' # _show_follow.html.erb will show all the follow page
    # _show_follow.html.erb is a partial file for following and followers page
  end

  # method and an assignment for our followers page
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 10)
    @all_users = @user.followers
    render 'show_follow'
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end


  # Before filters / before actions  -> A type of authorization


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
