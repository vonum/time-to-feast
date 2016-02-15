class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if current_user != nil
			@users = User.all
		else
			@users = User.where.not(id: current_user.id)
		end
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
