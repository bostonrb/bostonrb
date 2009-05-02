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

  def editing_time_remaining(job)
    if edit_job? job
      job.created_at - 15.minutes.ago
    else
      0.minutes
    end
  end

end
