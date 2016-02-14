class ExampleMailer < ApplicationMailer
  default from: "dkumar431@gmail.com"

  def sample_email(manager,agent)
    @user = manager
    @agent = agent
    mail(to: @user.email, subject: 'Agent Request - Pending Approval')
  end

end
