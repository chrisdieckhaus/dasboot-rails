class AvailabilitiesController < ApplicationController
	before_action :require_user, only: [:index, :show, :mine, :new, :edit]
	def index
		@avs = Availability.all
	end

	def new
		@av = Availability.new(av_params)
	end

	def create 
	  	@av = Availability.new(av_params) 
	  	@av.user_id = current_user.id
	  	avail = params[:availability]
	  	yyyy_s = avail["start_time"].split("/")[2]
		dd_s =  avail["start_time"].split("/")[1]
		mm_s = avail["start_time"].split("/")[0]
		yyyy_e = avail["end_time"].split("/")[2]
		dd_e =  avail["end_time"].split("/")[1]
		mm_e = avail["end_time"].split("/")[0]
		date = Date.new yyyy_s.to_i, mm_s.to_i, dd_s.to_i
		start_time = DateTime.new yyyy_s.to_i, mm_s.to_i, dd_s.to_i, avail["start_time(4i)"].to_i, avail["start_time(5i)"].to_i
		end_time = DateTime.new yyyy_e.to_i, mm_e.to_i, dd_e.to_i, avail["end_time(4i)"].to_i, avail["end_time(5i)"].to_i
		puts start_time
		puts end_time
		@av.start_time = start_time
		@av.end_time = end_time
		@av.save
		if @av.save 
			@user = User.find(@av.user_id)
			#UserMailer.update_availability(@user).deliver_later
		    redirect_to '/profile'
		else 
		    redirect_to new_availability_path 
		end 
	end

	def edit
		@av = Availability.find(params[:id])
		puts params
	end

	def update
		@av = Availability.find(params[:id])
		avail = params[:availability]
		start_time = DateTime.new avail["start_time(1i)"].to_i, avail["start_time(2i)"].to_i, avail["start_time(3i)"].to_i, avail["start_time(4i)"].to_i, avail["start_time(5i)"].to_i
		end_time = DateTime.new avail["end_time(1i)"].to_i, avail["end_time(2i)"].to_i, avail["end_time(3i)"].to_i, avail["end_time(4i)"].to_i, avail["end_time(5i)"].to_i
	  @av.start_time = start_time
	  @av.end_time = end_time
		@av.save
		if @av.save
			@user = User.find(@av.user_id)
			#UserMailer.update_availability(@user).deliver_later
			redirect_to '/profile'
		else
			render '/availabilities/edit/#{params[:id]}'
		end
	end

	def destroy
    	@av = Availability.find(params[:id])
    	@av.destroy
    	redirect_to availabilities_path
  	end

  	def show
  		@avs = Availability.where(:user_id => params[:id] )
  		@user = User.find(params[:id])
  	end

  	def mine
  	end

	private
  	def av_params
    	params.permit(:day_date, :start_time, :end_time)
  	end
end
