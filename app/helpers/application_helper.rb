module ApplicationHelper

	def link_for_user user
		if current_user.friends_with?(user)
			button_to 'Remove friend', friendship_path(user), method: :delete
		else
			link_to 'Send request', send_request_friendship_path(user)
		end
	end

	def name_for_user id
		user = User.find(id)
		user.name + " " + user.surname
	end

	def link_for_user_reservations
		if user_signed_in?
			if !current_user.admin
				link_to 'My Reservations', reservations_users_path
			end
		end
	end

	def name_for_restaurant id
		table = Table.find(id)
		restaurant = Restaurant.find(table.restaurant_id)
		restaurant.name
	end
end
