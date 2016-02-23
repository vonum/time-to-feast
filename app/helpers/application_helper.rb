module ApplicationHelper

	def link_for_user user
		if !current_user.admin
			if current_user.friends_with?(user)
				button_to 'Remove friend', friendship_path(user), method: :delete
			else
				link_to 'Send request', send_request_friendship_path(user)
			end
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

	def link_for_user_schedule
		if user_signed_in?
			if !current_user.admin
				link_to 'My Schedule', schedule_users_path
			end
		end
	end

	def name_for_restaurant id
		table = Table.find(id)
		restaurant = Restaurant.find(table.restaurant_id)
		restaurant.name
	end

	def link_for_adding_tables rest
		if admin_signed_in?
			link_to 'Add Table',  new_restaurant_table_path(rest)
		else
			if user_signed_in?
				if current_user.admin
					link_to 'Add Table',  new_restaurant_table_path(rest)
				end
			end
		end
	end

	def restaurant_id table
		table = Table.find(table)
		table.restaurant_id
	end

	def table_id reservation
		reservation = Reservation.find(reservation)
		reservation.table_id
	end

	def restaurant_name reservation
		reservation = Reservation.find(reservation)
		table = Table.find(reservation.table_id)
		restaurant = Restaurant.find(table.restaurant_id)
		restaurant.name
	end

	def reservation reservation
		reservation = Reservation.find(reservation)
		reservation
	end

	def add_reservation restaurant, table
		if user_signed_in?
			if !current_user.admin
				link_to 'Add Reservation', new_restaurant_table_reservation_path(restaurant, table)
			end
		end
	end

	def link_for_destroy_table restaurant, table
		if admin_signed_in?
			button_to 'Delete', restaurant_table_path(restaurant, table), method: :delete, class: 'btn'
		else
			if user_signed_in?
				if current_user.admin
					button_to 'Delete', restaurant_table_path(restaurant, table), method: :delete, class: 'btn'
				end
			end
		end
	end

	def reservations_for_table restaurant, table
		if admin_signed_in?
			link_to 'See Reservations', restaurant_table_reservations_path(restaurant, table)
		else
			if user_signed_in?
				if current_user.admin
					link_to 'See Reservations', restaurant_table_reservations_path(restaurant, table)
				end
			end
		end
	end

	def restaurant_reservations restaurant
		if admin_signed_in?
			link_to 'See Reservations', reservations_restaurant_path(restaurant)
		else
			if user_signed_in?
				if current_user.admin
					link_to 'See Reservations', reservations_restaurant_path(restaurant)
				end
			end
		end
	end
end
