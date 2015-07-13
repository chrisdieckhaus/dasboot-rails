class UsersController < ApplicationController
	before_action :require_user, only: [:index, :show]

	def index
    	@users = User.all
    	@current_shifts = Shift.where("end_time > ? AND start_time < ?", Time.now-(60*60*4), Time.now-(60*60*4))
    	@next_shifts = Shift.where("end_time > ? AND start_time < ?", Time.now-(60*60*3), Time.now-(60*60*3))
  	end

	def new
		@user = User.new
	end

	def create 
	  @user = User.new(user_params) 
	  if @user.save 
	    session[:user_id] = @user.id 
	    redirect_to '/' 
	  else 
	    redirect_to '/signup' 
	  end 
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to '/profile'
		else
			render '/profile'
		end
	end

	def show
		@user = User.find(params[:id])
	end

	def profile
		@user = current_user
	end

	def inkville
	end

	private
  	def user_params
    	params.require(:user).permit(:first_name, :last_name, :email, :password, :role)
  	end
end
