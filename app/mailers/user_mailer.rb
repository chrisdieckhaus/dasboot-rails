class UserMailer < ApplicationMailer
	default from: 'Das Boot'

	def create_shift(user, shift)
		@user = user
		@shift = shift
		mail(to: @user.email, subject: "You have been assigned to a new shift")
	end

	def update_shift(user, shift)
		@user = user
		@shift = shift
		mail(to: @user.email, subject: "Your shift has been changed")
	end
end
