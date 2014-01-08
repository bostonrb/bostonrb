class SessionsController < ApplicationController

  def create
    redirect_to root_path, notice: 'You have successfully signed in!'
  end

end
