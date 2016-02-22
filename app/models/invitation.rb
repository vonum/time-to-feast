class Invitation < ActiveRecord::Base
	belongs_to :reservation
	belongs_to :user

	validates_uniqueness_of :user, :scope => [:reservation]
end
