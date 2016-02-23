class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :reservation

	has_many :grades, dependent: :destroy

	validates_uniqueness_of :user, :scope => [:reservation]
end
