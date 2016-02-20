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

	end
end
