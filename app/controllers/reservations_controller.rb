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
		@reservation = @table.reservations.build(reservation_params)
		@reservation.user_id = current_user.id

		if check_dates(@reservation.finish, @reservation.start)
			if @reservation.save
				redirect_to root_path
			else
				redirect_to action: 'new'
			end
		else
			redirect_to reservations_users_path
		end

	end

	private
	def reservation_params
		params.require(:reservation).permit(:date, :start, :finish)
	end
	private def check_dates finish, start
		return (TimeDifference.between(finish, start).in_minutes > 30 and finish > start)
	end
end
