class ReservationsController < ApplicationController
	before_action :authenticate_user!
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

		if check_dates(@reservation.start, @reservation.finish, @reservation.date) and table_free(@table, @reservation)
			if @reservation.save
				redirect_to reservations_users_path
			else
				redirect_to action: 'new'
			end
		else
			redirect_to action: 'new'
		end
	end
	def show
		@reservation = Reservation.find(params[:id])
		@user = User.find(@reservation.user_id)
		@users = User.all
	end
	def invite
		@reservation = Reservation.find(params[:id])
		@invitation = Invitation.new
		@invitation.reservation_id = @reservation.id
		@invitation.user_id = params[:format]

		if @invitation.save
			redirect_to(:back)
		else
			redirect_to root_path
		end
	end


	private
	def reservation_params
		params.require(:reservation).permit(:date, :start, :finish)
	end
	private def check_dates start, finish, date
		return (TimeDifference.between(finish, start).in_minutes >= 30 and finish > start and date >= Date.today)
	end
	private
	def table_free table, reservation
		reservations = Reservation.where(table_id: reservation.table_id, date: reservation.date)
		reservations.each do |res|
			if ((res.finish >= reservation.start and res.finish <= reservation.finish) or (res.start >= reservation.start and res.start <= reservation.finish))
				return false
			end 
		end
		return true
	end
end
