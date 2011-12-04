class ProposalsController < ApplicationController
  def new
  end

  def create
    from = params[:proposal][:from]
    body = params[:proposal][:body]

    if body.blank?
      flash[:failure] = 'Email was not sent. Please enter some text.'
    else
      if from.blank?
        flash[:failure] = 'Email was not sent. Please enter your email address.'
      else
        Mailer.proposal(from, body).deliver
        flash[:success] = "Thank-you for submitting! You'll hear from us soon."
      end
    end

    redirect_to '/'
  end
end
