class Room < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :themes
  has_many :photos
  has_many :bookings, dependent: :destroy
  has_many :guests, through: :bookings, source: :user

  validates :address, presence: true
  validates :home_type, presence: true
  validates :room_type, presence: true
  validates :accommodate, presence: true
  validates :bedroom_count, presence: true
  validates :bathroom_count, presence: true
  validates :listing_name, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 500 }

  def available?(checkin, checkout)
    bookings.each do |booking|
      if (booking.starts_at <= checkout) && (booking.ends_at >= checkin)
        return false
      end
    end

    true
  end
end
