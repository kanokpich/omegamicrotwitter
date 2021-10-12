class MainController < ApplicationController
  def main
    session[:user_id] = nil
    if(!@user) 
      @user=User.new
    end
  end

  def login 
    @email = params[:email]
    @password = params[:password]

    @user = User.find_by(email:@email)

    if (@user && @user.authenticate(@password))
      session[:user_id] = @user.id
      redirect_to @user, notice: "Login successfully."
    else
      session[:user_id] = nil
      redirect_to '/main', alert: "Invalid email or password."
    end
  end
end
