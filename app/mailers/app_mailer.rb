class AppMailer < ApplicationMailer
  default from: "dkumar431@gmail.com"

  def agent_added_notification_mail(manager,agent)
    mail(to: manager.email, subject: 'Agent Request - Pending Approval')
  end

end
