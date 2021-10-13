class MainController < ApplicationController
  def main
    session[:user_id] = nil
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
        format.html { redirect_to '/main', notice: "Login successfully" }
        format.json { render json: @user }
      else
        session[:user_id] = nil
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :password_digest, :password, :password_confirmation)
    end

end
