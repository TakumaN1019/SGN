class ApplicationMailer < ActionMailer::Base
  default from: "TakumaN <sgn@takuman.me>" #SESの場合
  layout 'mailer'
end
