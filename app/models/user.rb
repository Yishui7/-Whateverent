class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :bookings, dependent: :destroy
  has_many :gyms, dependent: :destroy # Owners
  # has_many :booked_gyms, through: :bookings, ... some additional code to be written here if this line is needed.

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { in: 6..20 }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
