class AvailabilitiesController < ApplicationController
	def index
		@avs = Availability.all
	end

	def new
		@av = Availability.new(av_params)
	end

	def create 
	  @av = Availability.new(av_params) 
	  puts @av
	  @av.user_id = current_user.id
	  puts params
	  avail = params[:availability]
	  date = Date.new avail["day_date(1i)"].to_i, avail["day_date(2i)"].to_i, avail["day_date(3i)"].to_i
	  @av.day_date = date
	  @av.times = avail[:times]
	  @av.save
	  if @av.save 
	    redirect_to '/availabilities' 
	  else 
	    redirect_to '/availabilities/new' 
	  end 
	end

	def edit
		@av = Availability.find(params[:id])
		puts params
	end

	def update
		@av = Availability.find(params[:id])
		avail = params[:availability]
		date = Date.new avail["day_date(1i)"].to_i, avail["day_date(2i)"].to_i, avail["day_date(3i)"].to_i
		@av.day_date = date
		@av.times = avail[:times]
		@av.save
		if @av.save
			redirect_to '/availabilities'
		else
			render '/availabilities/edit/#{params[:id]}'
		end
	end

	def destroy
    	@av = Availability.find(params[:id])
    	@av.destroy
    	redirect_to '/availabilities'
  	end

	private
  	def av_params
    	params.permit(:day_date, :times)
  	end
end
