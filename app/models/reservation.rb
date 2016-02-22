class Reservation < ActiveRecord::Base
	belongs_to :user
	belongs_to :table

	has_many :invitations, dependent: :destroy
	has_many :events, dependent: :destroy

	validates :date, :start, :finish, presence: true
end
