class Schedule < ActiveRecord::Base
	has_many :shifts
	accepts_nested_attributes_for :shifts, allow_destroy: true
end
