class ReservationsController < ApplicationController
	def index
		@restaurant = Restaurant.find(params[:restaurant_id])
		@table = Table.find(params[:table_id])
		@reservations = @table.reservations
	end
	def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@table = Table.find(params[:table_id])
		@reservation = Reservation.new
	end
	def create
		@table = Table.find(params[:table_id])
		@reservation = @table.reservations.create(reservation_params)
		@reservation.user_id = current_user.id

		if @reservation.save
			redirect_to root_path
		else
			redirect_to action: 'new'
		end
	end

	private
	def reservation_params
		params.require(:reservation).permit(:date, :start, :finish)
	end
end
