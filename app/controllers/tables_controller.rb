class TablesController < ApplicationController
	before_action :check_manager

	def index
		@restaurant = Restaurant.find(params[:restaurant_id])
		@tables = @restaurant.tables
	end
	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@table = @restaurant.tables.build
	end
	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@table = @restaurant.tables.build(table_params)

		if @table.save
			redirect_to @restaurant
		else
			redirect_to action: 'new'
		end
	end


	private
	def table_params
		params.require(:table).permit(:noseats)
	end

	private
	def check_manager
		if !admin_signed_in?
			if user_signed_in?
				unless current_user.admin 
					redirect_to root_path
				end
			else
				redirect_to root_path
			end
		end
	end
end
