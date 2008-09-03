class UserSession
  
  def initialize(session)
    @session = session
    @session[:job_ids] = []
  end
  
  def add_job(job)
    @session[:job_ids] << job.id
  end
  
  def edit_job?(job)
    @session[:job_ids].include?(job.id) &&
      job.created_at > 15.minutes.ago
  end
  
end