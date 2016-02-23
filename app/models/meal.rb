class Meal < ActiveRecord::Base
	has_and_belongs_to_many :restaurants

	validates :name, :description, :price, presence: true
end
