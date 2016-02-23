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
		@future_events = Event.joins(:reservation).where("events.user_id = ? and reservations.date >= ?", current_user.id, Date.today)
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

		if @event.save
			@inv.destroy
		end

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
		#@events.includes(:reservation).includes(:user)

		#Article.includes(:comments).where("articles.published_at <= ? and comments.created_at >= ?", Time.now, Time.now - 1.month).references(:comments)
	end
	def grade
		@grade = Grade.new(grade_params)
		@grade.user_id = current_user.id
		if @grade.save
			redirect_to(:back)
		else
			redirect_to root_path
		end
	end
	def search
		search = params[:search]
		@users = User.where("name LIKE :name or surname LIKE :surname", name: "%#{search}%", surname: "%#{search}%")
	end
	private
	def grade_params
		params.permit(:grade, :event_id)
	end
end
