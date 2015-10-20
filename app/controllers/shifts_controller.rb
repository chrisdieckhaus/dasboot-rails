class ShiftsController < ApplicationController
	before_action :require_user, only: [:new, :show, :edit]

	def new
		@users = User.all 
		@schedule = Schedule.find(params[:schedule_id])
		@shift = Shift.new(shift_params)
	end

	def create
		shift_p = params[:shift]
		puts shift_p
		yyyy_s = shift_p["start_time"].split("/")[2]
		dd_s =  shift_p["start_time"].split("/")[1]
		mm_s = shift_p["start_time"].split("/")[0]
		yyyy_e = shift_p["end_time"].split("/")[2]
		dd_e =  shift_p["end_time"].split("/")[1]
		mm_e = shift_p["end_time"].split("/")[0]
		@shift = Shift.new(shift_params) 
		date = Date.new yyyy_s.to_i, mm_s.to_i, dd_s.to_i
		start_time = DateTime.new yyyy_s.to_i, mm_s.to_i, dd_s.to_i, shift_p["start_time(4i)"].to_i, shift_p["start_time(5i)"].to_i
		end_time = DateTime.new yyyy_e.to_i, mm_e.to_i, dd_e.to_i, shift_p["end_time(4i)"].to_i, shift_p["end_time(5i)"].to_i
		puts start_time
		puts end_time
		good_times = end_time >= start_time
		@shift.start_time = start_time
		@shift.end_time = end_time
		@shift.user_id = shift_p["user_id"]
		@shift.schedule_id = shift_p["schedule_id"]
		@shift.night_shift = shift_p["night_shift"]
		if good_times && @shift.save
			@user = User.find(shift_p[:user_id])
			UserMailer.create_shift(@user, @shift).deliver
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
		@shift.night_shift = shift_p["night_shift"]
		if good_times && @shift.save
			redirect_to schedule_path(shift_p['schedule_id'])
		else 
			redirect_to edit_shift_path(shift_p['schedule_id']), notice: 'Error.'
		end 
	end

	def destroy
    	@shift = Shift.find(params[:id])
    	schedule_id = @shift.schedule_id
    	@shift.destroy
    	redirect_to schedule_path(schedule_id)
  	end

  	def request_sub
  		@shift = Shift.find(params[:shift_id])
  		@schedule = @shift.schedule_id
  		@shift.sub_request = '1'
  		@shift.save
  		redirect_to schedule_path(@schedule)
  	end

  	def accept_sub
  		@shift = Shift.find(params[:shift_id])
  		@schedule = Schedule.find(params[:schedule_id])
  		@shift.sub_request = '0'
  		@shift.user_id = current_user.id
  		@shift.save
  		redirect_to schedule_path(@schedule)
  	end

	private
  	def shift_params
    	params.permit(:date, :start_time, :end_time, :night_shift)
  	end
end
