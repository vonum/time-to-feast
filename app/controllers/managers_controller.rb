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
		@manager.skip_confirmation!
		if @manager.save
			redirect_to action: 'index'
		else
			redirect_to action: 'new'
		end
	end
	def edit
		@manager = User.find(params[:id])
	end
	def update
		@manager = User.find(params[:id])
		if @manager.update(manager_params)
			redirect_to @manager
		else
			redirect_to action: 'edit'
		end
	end
	def destroy
		@manager = User.find(params[:id])
		@manager.destroy
		redirect_to action: 'index'
	end
	private
	def manager_params
		params.require(:manager).permit(:email, :name, :surname, :password)
	end
end
