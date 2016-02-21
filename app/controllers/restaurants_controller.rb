class RestaurantsController < ApplicationController

	before_action :authenticate_managers, except: [:index, :show]

	def index
		@rests = Restaurant.all
	end
	def show
		@rest = Restaurant.find(params[:id])
		@tables = @rest.tables
	end
	def new
		@rest = Restaurant.new
	end
	def create
		@rest = Restaurant.new(restaurant_params)

		if @rest.save
			redirect_to @rest
		else
			redirect_to new_restaurant_path
		end
	end
	def edit
		@rest = Restaurant.find(params[:id])
	end
	def update
		@rest = Restaurant.find(params[:id])

		if @rest.update(restaurant_params)
			redirect_to @rest
		else
			render 'edit'
		end
	end
	def destroy
		@rest = Restaurant.find(params[:id])

		if @rest.destroy
			redirect_to restaurants_path
		else
			redirect_to @rest
		end
	end

	private
	def restaurant_params
		params.require(:restaurant).permit(:name, :description)
	end
	private
	def authenticate_managers

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
