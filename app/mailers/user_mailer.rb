class UserMailer < ApplicationMailer
	default from: 'dasboot.tent@gmail.com'

	def welcome_email(user)
		@user = user
		@url = 'http://example.com/login'
		mail(to: 'christopherdieckhaus@gmail.com', subject: "hi")
	end
end
