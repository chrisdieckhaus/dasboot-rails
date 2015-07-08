class ShiftsController < ApplicationController
	def new
		@schedule = Schedule.find(params[:schedule_id])
		@shift = Shift.new(shift_params)
		puts @shift
	end

	def create 
		@shift = Shift.new(shift_params) 
		shift_p = params[:shift]
		date = Date.new shift_p["date(1i)"].to_i, shift_p["date(2i)"].to_i, shift_p["date(3i)"].to_i
		puts date
		asdf
		@av.day_date = date
		@av.times = avail[:times]
		@av.save
		if @av.save 
			redirect_to '/profile'
		else 
			redirect_to new_availability_path 
		end 
	end

	private
  	def shift_params
    	params.permit(:date, :start_time, :end_time)
  	end
end
