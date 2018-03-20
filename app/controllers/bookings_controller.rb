class BookingsController < ApplicationController

  def new
    @flight = Flight.find(params[:selected_flight])
    @booking = @flight.bookings.build
    params[:num_tickets].to_i.times { @booking.passengers.build }
  end

  def create
    @flight = Flight.find(params[:flight_id])
    @booking = @flight.bookings.build(booking_params)
    if @booking.save
      redirect_to booking_path(@booking)
    else
      render 'new'
    end
  end

  def show
    @booking = Booking.find(params[:id])
  end

  private

    def booking_params
      params.require(:booking).permit(:flight_id, :passengers_attributes => [:name, :email])
    end
end
