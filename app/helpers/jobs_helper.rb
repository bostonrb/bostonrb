module JobsHelper

  def list_job job
    html = "<strong>#{job.location}</strong>: "
    html << link_to(job.title, job_url(job))
    html << " at #{job.organization}"
    html
  end

  def job_title_and_company_name
    job     = html_escape("Rails developer")
    company = html_escape("thoughtbot")
    "#{link_to(job, '#')} &ndash; #{company}"
  end

end
