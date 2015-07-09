class Shift < ActiveRecord::Base
	belongs_to :user
	belongs_to :schedule
	validates_presence_of :user_id, :message => 'Please select a member'
end
