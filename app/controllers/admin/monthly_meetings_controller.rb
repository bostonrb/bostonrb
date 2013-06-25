class Admin::MonthlyMeetingsController < AdminController

  def index
    @monthly_meeting = MonthlyMeeting.first || MonthlyMeeting.new
  end

  def create
    @monthly_meeting = MonthlyMeeting.new(params[:monthly_meeting])

    respond_to do |format|
      if @monthly_meeting.save
        format.html { redirect_to admin_monthly_meetings_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def update
    @monthly_meeting = MonthlyMeeting.first

    respond_to do |format|
      if @monthly_meeting.update_attributes(params[:monthly_meeting])
        format.html { redirect_to admin_monthly_meetings_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

end
