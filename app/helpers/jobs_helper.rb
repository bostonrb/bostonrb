module JobsHelper
  
  def list_job job
    html = "<strong>#{job.location}</strong>: "
    html << link_to(job.title, job_url(job))
    html << " at #{job.organization}"
    html
  end
  
end
