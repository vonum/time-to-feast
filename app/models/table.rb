class Table < ActiveRecord::Base
	belongs_to :restaurant

	validates :noseats, :restaurant_id, presence: true
end
