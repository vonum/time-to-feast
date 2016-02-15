class FriendshipsController < ApplicationController

	before_action :authenticate_user!

	def accept_request
		@user = current_user
		sender = User.find(params[:id])

		@user.accept_request(sender)
		redirect_to @user
	end
	def destroy
		@user = current_user
		friend = User.find(params[:id])

		@user.remove_friend(friend)
		redirect_to @user

	end
	def send_request
		@user = current_user
		friend = User.find(params[:id])

		@user.friend_request(friend)
		redirect_to @user
	end
end
