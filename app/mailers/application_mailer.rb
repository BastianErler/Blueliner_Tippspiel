class ApplicationMailer < ActionMailer::Base
  default from: "noreply@bluelinerts.com"
  default 'Content-Transfer-Encoding' => '7bit'
  layout 'mailer'
end
