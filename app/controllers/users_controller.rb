class UsersController < ApplicationController
	before_filter :authorize, only: [:show]

	def new
		# redirect user if already logged in
		if current_user
			redirect_to profile_path
		else
			@user = User.new
			render :new
		end
	end

	def create
		# redirect user if already logged in
		if current_user
			redirect_to profile_path
		else
			user = User.new(user_params)
			if user.save
				session[:user_id] = user.id
				flash[:notice] = "Successfully signed up."
				# redirect_to "/profile"
				# refactored with route helpers:
				redirect_to profile_path
			else
				flash[:error] = user.errors.full_messages.join(', ')
				# redirect_to "/signup"
				# refactored with route helpers:
				redirect_to signup_path
			end
		end
	end

	def show
		render :show
	end

	private
		def user_params
			params.require(:user).permit(:email, :password, :password_confirmation)
		end
end