class ProblemAttemptsController < ApplicationController
  def index
    @attempts = ProblemAttempt.all
    respond_to do |format|
      format.html
    end
  end

  def show
    @attempt = ProblemAttempt.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def download
    @attempt = ProblemAttempt.find(params[:id])
    send_file("#{RAILS_ROOT}/public/upload/#{@attempt.filename}", :type => @attempt.filetype, :stream => true)
  end

  def waiting
    @attempts = ProblemAttempt.find_all_by_status('Waiting')
    respond_to do |format|
      format.html
    end
  end

  def edit
    if !session[:user].is_admin?
      return redirect_to(root_path, :error => "Must be admin to edit problem status")
    end
    @attempt = ProblemAttempt.find(params[:id])
  end

  def update
    if !session[:user].is_admin?
      return redirect_to(root_path, :error => "Must be admin to edit problem status")
    end
    @attempt = ProblemAttempt.find(params[:id])
    @attempt.status = params[:status]
    @attempts = ProblemAttempt.where(["user_id=? AND problem_id = ? AND status = ?", session[:user].id, @attempt.problem.id, "Success"])
    respond_to do |format|
      if @attempt.save
        format.html { redirect_to((waiting_problem_attempts_path), :notice => 'Problem attempt updated')}
      else
        format.html { render :action => "edit"}
      end
    end
  end

  def create
    @problem_attempt = ProblemAttempt.new
    if params[:problem_attempt].nil?
      flash[:error] = "No file selected for submission!"
      return redirect_to(problem_path(params[:problem_id]))
    end
    # don't know why there isn't a headers hash available. 
    # had to dig into the actual request hash from rack
    information = request.headers['rack.request.form_hash']['problem_attempt']['source_code']
    information.each do |key,value|
      puts "#{key} -- #{value}"
    end
    @problem_attempt.create_files(params[:problem_attempt][:source_code], information[:filename])
    @problem_attempt.user_id = session[:user].id
    @problem_attempt.problem_id = params[:problem_id]
    @problem_attempt.filetype = information[:type]
    respond_to do |format|
      if @problem_attempt.save
        format.html { redirect_to(problem_path(params[:problem_id]), :notice => 'Submission Accepted!') }
      else
        format.html { render :action => "new" }
      end
    end
  end
end
