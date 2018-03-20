class Flight < ApplicationRecord
  validates :date, presence: true
  validates :duration, presence: true, format: { with: /[0-9]{2}h[0-5][0-9]m/ }
  validate  :start_does_not_equal_destination
  belongs_to :from_airport, :class_name => "Airport"
  belongs_to :to_airport,   :class_name => "Airport"
  has_many :bookings

  def date_formatted
    date.strftime("%d %B %Y")
  end

  def start_does_not_equal_destination
    errors.add(:base, "Start can not be the same as destination.") if from_airport == to_airport
  end
end
