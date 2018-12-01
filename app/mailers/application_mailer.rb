class ApplicationMailer < ActionMailer::Base
  default from: 'admin@recordpool.herokuapp.com'
  layout 'mailer'
end
