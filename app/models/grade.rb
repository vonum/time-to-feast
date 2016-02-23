class Grade < ActiveRecord::Base
	belongs_to :event
	belongs_to :user

	validates :grade, presence: true
	validates_uniqueness_of :user, :scope => [:event]
end
