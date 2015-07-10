class Shift < ActiveRecord::Base
	belongs_to :user
	belongs_to :schedule
	validates_presence_of :user_id, :message => 'Please select a member'

	def night_shift?
		self.night_shift == '1'
	end

	def weekend_night?
		self.night_shift? && (self.start_time.strftime("%H%M") == "0230") 
	end
end