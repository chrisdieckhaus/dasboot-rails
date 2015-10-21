class SchedulesController < ApplicationController
	before_action :require_user, only: [:index, :show, :new, :edit]

	def index
		@schedules = Schedule.all
	end

	def new
		@schedule = Schedule.new(schedule_params)
	end

	def create 
		@schedule = Schedule.new(schedule_params) 
		sched = params[:schedule]
		start_date = Date.new sched["start_date(1i)"].to_i, sched["start_date(2i)"].to_i, sched["start_date(3i)"].to_i
		end_date = Date.new sched["end_date(1i)"].to_i, sched["end_date(2i)"].to_i, sched["end_date(3i)"].to_i
		@schedule.start_date = start_date
		@schedule.end_date = end_date
		@schedule.schedule_name = sched[:schedule_name]
		if @schedule.save 
			UserMailer.create_schedule(@schedule).deliver_later
			redirect_to '/schedules' 
		else 
			redirect_to '/schedules/new' 
		end 
	end

	def update
		@schedule = Schedule.find(params[:id])
		sched = params[:schedule]
		start_date = Date.new sched["start_date(1i)"].to_i, sched["start_date(2i)"].to_i, sched["start_date(3i)"].to_i
		end_date = Date.new sched["end_date(1i)"].to_i, sched["end_date(2i)"].to_i, sched["end_date(3i)"].to_i
		@schedule.start_date = start_date
		@schedule.end_date = end_date
		@schedule.schedule_name = sched[:schedule_name]
		if @schedule.save
			redirect_to '/schedules'
		else
			render '/schedules/edit/#{params[:id]}'
		end
	end

	def edit
		@schedule = Schedule.find(params[:id])
	end

	def destroy
		@schedule = Schedule.find(params[:id])
		@schedule.destroy
		redirect_to '/schedules'
	end

	def show
  		@schedule = Schedule.find(params[:id])
  	end

	private
  		def schedule_params
    		params.permit(:start_date, :end_date, :schedule_name)
  		end
end
