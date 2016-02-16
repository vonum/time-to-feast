module ApplicationHelper

	def link_for_user user
		if current_user.friends_with?(user)
			button_to 'Remove friend', friendship_path(user), method: :delete
		else
			link_to 'Send request', send_request_friendship_path(user)
		end
	end
end
