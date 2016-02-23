class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if current_user == nil
			@users = User.all
		else
			@users = User.where.not(id: current_user.id)
		end
	end
	def show
		@user = User.find(params[:id])
	end
	def profile
		@user = current_user
		@friends = @user.friends
		@invitations = @user.invitations.includes(:reservation).includes(:user)
	end
	def friends

	end
	def reservations
		@user = current_user
		@reservations = @user.reservations
	end
	def accept_invite
		@user = current_user
		@inv = Invitation.find(params[:id])
		
		@event = Event.new
		@event.user_id = current_user.id
		@event.reservation_id = @inv.reservation_id

		@event.save
		@inv.destroy

		redirect_to action: 'profile'
	end
	def decline_invite

		@inv = Invitation.find(params[:id])
		@inv.destroy

		redirect_to action: 'profile'
	end
	def schedule
		@data = current_user.events.includes(:reservation).includes(:user)
		@past_events = Event.joins(:reservation).where("events.user_id = ? and reservations.date <= ?", current_user.id, Date.today)
		@future_events = Event.joins(:reservation).where("events.user_id = ? and reservations.date >= ?", current_user.id, Date.today)
		#@events = Event.where(user_id: current_user.id)
		#@events = Event.joins(:reservation).where("events.reservation_id = reservations.reservation_id and reservations.date < ?", Date.today)
		#@events.includes(:reservation).includes(:user)

		#@events = current_user.events
		#Account.joins(:details).where("details.name" => selected_detail).first
		#Person.joins('LEFT JOIN "notes" ON "notes"."person_id" = "people.id" AND "notes"."important" IS "t"')

		#Article.includes(:comments).where("articles.published_at <= ? and comments.created_at >= ?", Time.now, Time.now - 1.month).references(:comments)
	end
end
