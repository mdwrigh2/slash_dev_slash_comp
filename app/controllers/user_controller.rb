class UsersController < ApplicationController
  def index
    if session[:user]
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html
      format.xml { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    
    respond_to do |format|
      if @user.save
        session[:user] = User.authenticate(@user.username, @user.password)
        format.html { redirect_to(@user,
                                  :notice => 'Signup Successful!') }
        format.xml { redirect_to(@user,
                                 :status => :created, :location => @user) }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors,
                     :status => :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html 
      format.xml { render :xml => @user }
    end
  end
end
