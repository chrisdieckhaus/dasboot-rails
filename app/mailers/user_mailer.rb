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

	def create_schedule(schedule)
		@schedule = schedule
		@users = User.all
		@users.each do |user|
			mail(to: user.email, subject: "#{@schedule.schedule_name} schedule")
		end
	end

	def sub_requested(user, shift)
		@user = user
		@shift = shift
		@users = User.all
		@users.each do |u|
			mail(to: u.email, subject: "Sub requested by #{@user.first_name} #{@user.last_name}")
		end
	end
end
