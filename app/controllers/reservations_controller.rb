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

		if check_dates(@reservation.start, @reservation.finish, @reservation.date)
			if @reservation.save
				redirect_to reservations_users_path
			else
				redirect_to action: 'new'
			end
		else
			redirect_to action: 'new'
		end

	end

	private
	def reservation_params
		params.require(:reservation).permit(:date, :start, :finish)
	end
	private def check_dates start, finish, date
		return (TimeDifference.between(finish, start).in_minutes > 30 and finish > start and date > Date.today)
	end
	private
	def table_free table

	end
end
