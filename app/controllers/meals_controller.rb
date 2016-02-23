class MealsController < ApplicationController
	def index
		@meals = Meal.all
	end
	def new
		@meal = Meal.new
	end
	def create
		@meal = Meal.new(meal_params)
		if @meal.save
			redirect_to action: 'index'
		else
			redirect_to action: 'new'
		end
	end
	def destroy
		@meal.destroy
		redirect_to action: 'index'
	end
	def edit
		@meal = Meal.find(params[:id])
	end
	def update
		@meal = Meal.find(params[:id])
		if @meal.update(meal_params)
			redirect_to action: 'index'
		else
			render 'edit'
		end
	end
	private
	def meal_params
		params.require(:meal).permit(:name, :description, :price)
	end
end
