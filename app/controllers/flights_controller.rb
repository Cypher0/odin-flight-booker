class FlightsController < ApplicationController

  def index
    @airport_options = Airport.all.map { |airport| [airport.name, airport.id] }
    sorted_flights = Flight.all.sort_by(&:date)
    @available_dates = sorted_flights.map { |flight| flight.date_formatted }.uniq
    if params[:date]
      @flight_results = Flight.where(from_airport_id: params[:from_airport],
                                     to_airport_id: params[:to_airport],
                                     date: Date.parse(params[:date]).all_day).sort_by(&:date)
    else
      @flight_results = []
    end
  end
end
