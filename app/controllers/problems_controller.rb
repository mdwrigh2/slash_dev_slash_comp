class ProblemsController < ApplicationController
  def index
    if session[:user].is_admin
      redirect_to(all_problems_path)
      return
    end
    @problems = Problem.where(['visible = ?', true])
    respond_to do |format|
      format.html
    end
  end

  def all
    if !session[:user].is_admin
      flash[:error] = "Must be an admin to view all problems"
      redirect_to(problems_path)
      return
    end
    @visible_problems = Problem.where(['visible = ?', true])
    @hidden_problems = Problem.where(['visible = ?',false])
    respond_to do |format|
      format.html
    end
  end

  def show
    @problem = Problem.find(params[:id])
    @problem_attempt = ProblemAttempt.new
    if !@problem.visible and !session[:user].is_admin
      flash[:error] = "Problem not visible yet. No cheating!"
      redirect_to(problems_path)
    end
    @attempts = ProblemAttempt.where(['user_id = ? AND problem_id = ?', session[:user].id, params[:id]])
    respond_to do |format|
      format.html
    end
  end

  def new
    redirect_to(logins_path, :notice => 'Login Required') unless session[:user].is_admin
    @problem = Problem.new
    respond_to do |format|
      format.html
    end
  end
  
  def create
    redirect_to(logins_path, :notice => 'Login Required') unless session[:user].is_admin

    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        format.html { redirect_to(@problem, :notice => 'Problem successfully created!') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def delete

  end

  def edit
    redirect_to(logins_path, :notice => 'Login Required') unless session[:user].is_admin
    @problem = Problem.find(params[:id])
  end
  
  def update
    redirect_to(logins_path, :notice => 'Login Required') unless session[:user].is_admin
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to(@problem, :notice => 'Problem was successfully updated.')}
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def update_problems
    redirect_to(logins_path, :notice => 'Login Required') unless session[:user].is_admin
    Problem.update_all(['visible = ?', true], :id => params[:visible_ids])
    Problem.update_all(['visible = ?', false], :id => params[:hidden_ids])
    p params
    flash[:notice] = "Problems update successful"
    redirect_to(all_problems_path)
  end
end
