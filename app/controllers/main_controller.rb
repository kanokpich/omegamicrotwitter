class MainController < ApplicationController
  before_action :set_user, only: %i[ feed new_post ]
  before_action :valid_user_check, only: %i[ feed new_post ]
  before_action :login_check, only: %i[ profile ] 

  def main
    session.delete(:user_id)
    if(!@user) 
      @user=User.new
    end
  end

  def login 
    @email = params[:user][:email]
    @password = params[:user][:password]

    @user = User.find_by(email:@email)

    respond_to do |format|
      if @user && @user.authenticate(@password)
        session[:user_id] = @user.id
        format.html { redirect_to '/feed?user_id='+@user.id.to_s, notice: "Login successfully" }
        format.json { render json: @user }
      else
        session.delete(:user_id)
        format.html { redirect_to '/main',alert: "Invalid Email or Password. please try again" }
        format.json { render json: @user.errors,status: :unprocessable_entity}
      end
    end
  end

  def register
    @user = User.new
  end

  def regsiter_create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to '/main', notice: "Register successfully." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :register, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def feed 
    @list = [@user.id]
    @user.follower.each { |follow|
      @list.push(follow.followee_id)
    }
    @feed_posts = Post.where(:user_id => @list).sort_by {|post| post.created_at}.reverse!
  end

  def new_post
    @post = Post.new
    @post.user_id = params[:user_id]
  end

  def create_post
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/feed?user_id='+@post.user.id.to_s, notice: "create post successfully" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def profile
    if(!params[:name])
      @profile_user = @user
    elsif(params[:name]==@user.name)
      respond_to do |format|
        format.html { redirect_to '/profile' }
      end
    else
      @profile_user = User.find_by(name:params[:name])
      @isFollowed=Follow.find_by(follower_id:@user.id,followee_id:@profile_user.id)

    end
  end

  def follow 
    @user = User.find(params[:user][:id])
    @to_follow=User.find(params[:user_id])
    if(params[:commit]=='Follow')
      Follow.create(follower:@user,followee:@to_follow).save
      respond_to do |format|
      format.html { redirect_to '/profile/'+@to_follow.name}
    end
    elsif(params[:commit]=='Unfollow')
      Follow.find_by(follower:@user,followee:@to_follow).destroy
        respond_to do |format|
        format.html { redirect_to '/profile/'+@to_follow.name}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      if(params[:user_id] && User.find(params[:user_id]))
        @user = User.find(params[:user_id])
      else
        redirect_to main_path, alert: "Please login."
      end
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password_digest, :password, :password_confirmation)
    end

    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:user_id, :msg)
    end
    
    def login_check 
      if(session[:user_id])
        @user=User.find(session[:user_id])
      else
        redirect_to main_path, alert: "Please Login."
      end
    end

    def post_check
      @post = Post.new(post_params)
      if( @post.user_id!=session[:user_id])
        redirect_to main_path, alert: "Please post with your current user."
        return false
      end
    end

    def valid_user_check
      if @user  && session[:user_id]==@user.id
        return true
      else
        redirect_to main_path, alert: "Access denied."
        return false
      end
    end
end
