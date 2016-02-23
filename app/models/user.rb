class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_friendship

  has_many :reservations
  has_many :tables, through: :reservations

  has_many :invitations, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :grades, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :name, :surname, presence: true

end
