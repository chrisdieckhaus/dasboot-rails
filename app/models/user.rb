class User < ActiveRecord::Base
	has_secure_password
	has_many :availabilities
	has_many :shifts
end
