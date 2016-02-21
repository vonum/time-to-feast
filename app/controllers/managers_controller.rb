class ManagersController < ApplicationController
	before_action :authenticate_admin!, except: [:index, :show]

	def index
		@managers = User.where(admin: true)
	end
	def show
		@manager = User.find(params[:id])
	end
	def new
		@manager = User.new
	end
	def create
		@manager = User.new(manager_params)
		@manager.admin = true
		if @manager.save
			redirect_to action: 'index'
		else
			redirect_to action: 'new'
		end
	end
	private
	def manager_params
		params.require(:user).permit(:email, :name, :surname, :password)
	end
end
