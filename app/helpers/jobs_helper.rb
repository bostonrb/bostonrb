module JobsHelper

  def list_job job
    html = "<strong>#{job.location}</strong>: "
    html << link_to(job.title, job_url(job))
    html << " at #{job.organization}"
    html
  end

  def job_link
    name = html_escape("Rails developer")
    link = html_escape("jobs/5")
    link_to name, link
  end

end
