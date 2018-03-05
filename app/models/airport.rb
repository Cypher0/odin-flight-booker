class Airport < ApplicationRecord
  before_save :upcase_code
  validates :name, presence: true, length: { maximum: 50 }
  validates :code, presence: true, length: { is: 3},
                   format: { with: /[A-Za-z]{3}/ },
                   uniqueness: { case_sensitive: false }
  has_many :departing_flights, :class_name => "Flight", :foreign_key => "from_airport_id"
  has_many :arriving_flights,  :class_name => "Flight", :foreign_key => "to_airport_id"

  def upcase_code
    self.code.upcase!
  end
end
