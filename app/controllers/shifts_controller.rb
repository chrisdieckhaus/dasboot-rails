class ShiftsController < ApplicationController
	def new
		@users = User.all 
		@schedule = Schedule.find(params[:schedule_id])
		@shift = Shift.new(shift_params)
		puts @shift
	end

	def create
		shift_p = params[:shift]
		@shift = Shift.new(shift_params) 
		date = Date.new shift_p["start_time(1i)"].to_i, shift_p["start_time(2i)"].to_i, shift_p["start_time(3i)"].to_i
		start_time = DateTime.new shift_p["start_time(1i)"].to_i, shift_p["start_time(2i)"].to_i, shift_p["start_time(3i)"].to_i, shift_p["start_time(4i)"].to_i, shift_p["start_time(5i)"].to_i
		end_time = DateTime.new shift_p["end_time(1i)"].to_i, shift_p["end_time(2i)"].to_i, shift_p["end_time(3i)"].to_i, shift_p["end_time(4i)"].to_i, shift_p["end_time(5i)"].to_i
		good_times = end_time >= start_time
		@shift.start_time = start_time
		@shift.end_time = end_time
		@shift.user_id = shift_p["user_id"]
		@shift.schedule_id = shift_p["schedule_id"]
		if good_times && @shift.save
			redirect_to schedule_path(shift_p['schedule_id'])
		else 
			redirect_to schedule_shifts_new_path(shift_p['schedule_id']), notice: 'Error.'
		end 
	end

	def edit
		@shift = Shift.find(params[:id])
	end

	def update
		@shift = Shift.find(params[:id])
		shift_p = params[:shift]
		date = Date.new shift_p["start_time(1i)"].to_i, shift_p["start_time(2i)"].to_i, shift_p["start_time(3i)"].to_i
		start_time = DateTime.new shift_p["start_time(1i)"].to_i, shift_p["start_time(2i)"].to_i, shift_p["start_time(3i)"].to_i, shift_p["start_time(4i)"].to_i, shift_p["start_time(5i)"].to_i
		end_time = DateTime.new shift_p["end_time(1i)"].to_i, shift_p["end_time(2i)"].to_i, shift_p["end_time(3i)"].to_i, shift_p["end_time(4i)"].to_i, shift_p["end_time(5i)"].to_i
		good_times = end_time >= start_time
		@shift.start_time = start_time
		@shift.end_time = end_time
		@shift.user_id = shift_p["user_id"]
		@shift.schedule_id = shift_p["schedule_id"]
		if good_times && @shift.save
			redirect_to schedule_path(shift_p['schedule_id'])
		else 
			redirect_to edit_shift_path(shift_p['schedule_id']), notice: 'Error.'
		end 
	end

	private
  	def shift_params
    	params.permit(:date, :start_time, :end_time)
  	end
end
