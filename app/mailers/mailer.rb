class Mailer < ActionMailer::Base
  default :to => ["admin@bostonrb.org","dcroak@thoughtbot.com"]

  def proposal(sender, custom_body)
    @custom_body = custom_body
    mail :from => sender, :subject => "[boston.rb] proposal"
  end
end
