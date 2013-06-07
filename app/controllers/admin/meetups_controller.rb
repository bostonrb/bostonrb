class Admin::MeetupsController < AdminController

  def index
    @meetup = Meetup.first
  end

  def update
    @meetup = Meetup.first
    @submit_url = admin_meetup_path(@meetup)
    @method = :put

    respond_to do |format|
      if @meetup.update_attributes(params[:meetup])
        format.html { redirect_to admin_meetups_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

end
