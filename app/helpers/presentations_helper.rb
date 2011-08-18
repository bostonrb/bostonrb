module PresentationsHelper
  def presentations_index_header
    if params[:month]
      Date.parse(params[:month]).to_time.to_s(:month_and_year)
    else
      'Past presentations'
    end
  end
end
