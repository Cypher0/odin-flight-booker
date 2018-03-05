# Airports
Airport.delete_all
airport_data = { "Pärnu Airport" => "EPU",
                 "Helsinki Vantaa Airport" => "HEL",
                 "Sydney West" => "SWZ",
                 "London Heathrow Airport" => "LHR",
                 "Miami International Airport" => "MIA" }
airport_data.each do |name, code|
  Airport.create!(name: name, code: code)
end

# Flights
Flight.delete_all
(1..5).each do |from|
  (1..5).each do |to|
    unless from == to
      random_date = Date.today + rand(100)
      random_duration = "#{rand(99).to_s.rjust(2, '0')}"
      Flight.create!(from_airport_id: from, to_airport_id: to, date: random_date, 
                     duration: "#{random_duration}h#{random_duration}m" )
    end
  end
end
