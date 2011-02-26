class UsersController < ApplicationController
  def index
    if !session[:user].nil? and session[:user].is_admin
      @users = User.all
    else
      redirect_to(root_path)
    end
  end

  def leaderboard
    @users = User.all
    @sorted_users = []
    @users.each do |user|
      store = []
      successes = ProblemAttempt.where(['user_id = ? AND status = ?', user.id, 'Success'])
      s = 0
      successes.each do |succ|
        if !store[succ.problem.id]
          store[succ.problem.id] = 1
          s += 1
        end
      end
      @sorted_users << [s, user]
    end
    @sorted_users.sort! do |a,b|
      a[0] <=> b[0]
    end
    
    @sorted_users.reverse!

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
