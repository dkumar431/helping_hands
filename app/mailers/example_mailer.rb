class ExampleMailer < ApplicationMailer
  default from: "dkumar431@gmail.com"

  def sample_email(manager,agent)
    mail(to: manager.email, subject: 'Agent Request - Pending Approval')
  end

end
