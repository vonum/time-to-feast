class UsersController < ApplicationController
	before_action :authenticate_user!

	def index
		@users = User.all
	end
	def show
		@user = current_user
	end
	def profile
		@user = current_user
		@friends = @user.friends
	end
	def friends

	end
end
