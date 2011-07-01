module PresentationsHelper
  def presentations_index_header
    if params[:month]
      Date.parse(params[:month]).strftime('%B %Y')
    else
      'Past presentations'
    end
  end
end
