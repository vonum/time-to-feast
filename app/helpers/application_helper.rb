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
				link_to 'Timeline', schedule_users_path
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

	def manager_signed_in
		if admin_signed_in?
			return true
		else
			if user_signed_in?
				if current_user.admin
					return true
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

	def grade_present user, event
		Grade.exists?(user_id: user, event_id: event)
	end

	def grade user, event
		Grade.where(user_id: user, event_id: event).first.grade
	end

	def grade_for_restaurant rest
		sql = "SELECT restaurants.name, tables.id, reservations.id, events.id, grades.id, grades.grade
				FROM restaurants
				INNER JOIN tables
				ON restaurants.id = tables.restaurant_id
				and restaurants.id = " + rest.id.to_s + "
				INNER JOIN reservations
				ON reservations.table_id = tables.id
				INNER JOIN events
				ON events.reservation_id = reservations.id
				INNER JOIN grades
				ON grades.event_id = events.id;"
		records_array = ActiveRecord::Base.connection.execute(sql)
		#avg = 0
		#unless grades.size == 0
		#	grades.each do |grade|
		#		avg = avg + grade.grade
		#	end
		#	avg = avg / grades.size
		#end
		#avg
		records_array.size
	end
	def add_or_delete_meal rest, meal
		unless rest.meals.include?(meal)
			button_to 'Add Meal', add_meal_restaurant_path(@rest, meal), method: :post, class: 'btn'
		else
			button_to 'Delete Meal', delete_meal_restaurant_path(@rest, meal), method: :post, class: 'btn'
		end
	end
end
