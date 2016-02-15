class RestaurantsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :show]


	def index
		@rests = Restaurant.all
	end
	def show
		@rest = Restaurant.find(params[:id])
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
end
