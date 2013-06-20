class Admin::MeetupsController < AdminController

  def index
    @meetup = Meetup.first || Meetup.new
  end

  def create
    @meetup = Meetup.new(params[:meetup])
    @submit_url = admin_meetups_path(@meetup)

    respond_to do |format|
      if @meetup.save
        format.html { redirect_to admin_meetups_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

  def update
    @meetup = Meetup.first
    @submit_url = admin_meetup_path(@meetup)

    respond_to do |format|
      if @meetup.update_attributes(params[:meetup])
        format.html { redirect_to admin_meetups_path }
      else
        format.html { render :action => "index" }
      end
    end
  end

end
