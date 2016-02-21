class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :table

	validates :date, :start, :finish, presence: true
end
