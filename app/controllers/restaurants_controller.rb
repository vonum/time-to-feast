class RestaurantsController < ApplicationController

	before_action :authenticate_managers, except: [:index, :show, :meals, :search]

	def index
		@rests = Restaurant.all
	end
	def show
		@rest = Restaurant.find(params[:id])
		@tables = @rest.tables
	end
	def new
		@restaurant = Restaurant.new
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
		@restaurant = Restaurant.find(params[:id])
	end
	def update
		@restaurant = Restaurant.find(params[:id])

		if @restaurant.update(restaurant_params)
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

	def reservations
		@rest = Restaurant.find(params[:id])
		@tables = @rest.tables
	end
	def meals
		@rest = Restaurant.find(params[:format])
		@meals = @rest.meals
	end
	def edit_meals
		@rest = Restaurant.find(params[:format])
		@meals = Meal.all
	end
	def add_meal
		@rest = Restaurant.find(params[:id])
		@meal = Meal.find(params[:format])

		@rest.meals.push(@meal)

		redirect_to(:back)

	end
	def delete_meal
		@rest = Restaurant.find(params[:id])
		@meal = Meal.find(params[:format])

		@rest.meals.delete(@meal)

		redirect_to(:back)
	end
	def search
		search = params[:search]
		@rests = Restaurant.where("name LIKE :name or description LIKE :description", name: "%#{search}%", description: "%#{search}%")
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
