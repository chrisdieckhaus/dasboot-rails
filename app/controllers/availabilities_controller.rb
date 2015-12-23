class AvailabilitiesController < ApplicationController
	before_action :require_user, only: [:index, :show, :mine, :new, :edit]
	def index
		@avs = Availability.all
	end

	def new
		@av = Availability.new(av_params)
	end

	def create 
		avail = params[:availability]
		puts avail

		yyyy_s = avail["start_time"].split("/")[2]
		dd_s =  avail["start_time"].split("/")[1]
		mm_s = avail["start_time"].split("/")[0]

		d = Date.parse(yyyy_s+"-"+mm_s+"-"+dd_s)
	
		times = avail["times"].split(",")
		times.each do |t|
			start_time = t.split("-")[0]
			end_time = t.split("-")[1]
			puts "start: #{start_time}"
			puts "end: #{end_time}"
			st = Time.parse(start_time, d)
			et = Time.parse(end_time, d)
			@av = Availability.new(av_params)
			@av.user_id = current_user.id
			@av.start_time = st
			@av.end_time = et
			@av.save
		end

		redirect_to '/profile'
	end

	def edit
		@av = Availability.find(params[:id])
		puts params
	end

	def update
		@av = Availability.find(params[:id])
		avail = params[:availability]
		puts avail

		sd = Date.parse(avail["start_time(1i)"]+"-"+avail["start_time(2i)"]+"-"+avail["start_time(3i)"])
		ed = Date.parse(avail["end_time(1i)"]+"-"+avail["end_time(2i)"]+"-"+avail["end_time(3i)"])

		puts sd
		puts ed

		start_time = avail["start_time(4i)"]+":"+avail["start_time(5i)"]
		end_time = avail["end_time(4i)"]+":"+avail["end_time(5i)"]
	  	@av.start_time = Time.parse(start_time, sd)
	  	@av.end_time = Time.parse(end_time, ed)

	  	puts @av.start_time
	  	puts @av.end_time
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

  	def copy_time
  		puts "hi"
  		puts params
  		av_to_copy = Availability.find(params[:avail_id])
  		puts av_to_copy
  		@new_av = Availability.new(av_params)
  		@new_av.user_id = params[:user_id]
  		@new_av.start_time = av_to_copy.start_time+1.week.to_i
  		@new_av.end_time = av_to_copy.end_time+1.week.to_i
  		@new_av.save
  		redirect_to availabilities_path
  	end

  	def mine
  	end

	private
  	def av_params
    	params.permit(:day_date, :start_time, :end_time)
  	end
end
