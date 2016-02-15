class Restaurant < ActiveRecord::Base
	has_many :tables, dependent: :destroy

	validates :name, :description, presence: true
end
