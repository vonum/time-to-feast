class Event < ActiveRecord::Base
	belongs_to :user
	belongs_to :reservation

	validates_uniqueness_of :user, :scope => [:reservation]
end
