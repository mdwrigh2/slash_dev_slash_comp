class LoginsController < ApplicationController

  def new
    @user = User.new
    respond_to do |format|
      format.html
    end
  end

  def create
    respond_to do |format|
      if session[:user] = User.authenticate(params[:username], params[:password])
        format.html { redirect_to(problems_path, :notice => 'Login Successful')}
      else
        format.html { redirect_to(new_login_path, :error => 'Login Failed') }
      end
    end
  end

  def destroy
    session[:user] = nil
    redirect_to root_url
  end

end
