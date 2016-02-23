class FriendshipsController < ApplicationController

	before_action :authenticate_user!

	def accept_request
		@user = current_user
		sender = User.find(params[:id])

		@user.accept_request(sender)
		redirect_to(:back)
	end
	def destroy
		@user = current_user
		friend = User.find(params[:id])

		@user.remove_friend(friend)
		redirect_to(:back)

	end
	def send_request
		@user = current_user
		friend = User.find(params[:id])

		#@user.friend_request(friend) unless (@user.admin or friend.admin)
		@user.friend_request(friend) unless validate_users(@user, friend)
		redirect_to(:back)
	end
	def decline_request
		@user = current_user
		friend = User.find(params[:id])

		@user.decline_request(friend)
		redirect_to(:back)
	end

	private
	def validate_users user, friend
		return ((user.admin or friend.admin) or (user.id == friend.id))
	end
end
