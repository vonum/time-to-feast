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
		@data = Event.includes(:reservation).includes(:user)
	end
end
