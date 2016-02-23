class Restaurant < ActiveRecord::Base
	has_many :tables, dependent: :destroy
	has_and_belongs_to_many :meals

	validates :name, :description, presence: true
end
