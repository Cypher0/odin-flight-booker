class AddBookingRefToPassengers < ActiveRecord::Migration[5.1]
  def change
    add_reference :passengers, :booking
  end
end
