class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :profile
  has_many :rooms, dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_many :booked_rooms, through: :bookings, source: :room

  def full_name
    return profile.full_name if profile?

    email
  end

  def profile?
    profile.present? && profile.persisted?
  end
end
