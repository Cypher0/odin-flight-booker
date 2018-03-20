# Airports
Airport.delete_all
airport_data = { "Pärnu Airport" => "EPU",
                 "Helsinki Vantaa Airport" => "HEL",
                 "Sydney West" => "SWZ",
                 "London Heathrow Airport" => "LHR",
                 "Miami International Airport" => "MIA",
                 "Dubai International Airport" => "DBX",
                 "Tokyo Haneda International Airport" => "HND",
                 "Hong Kong International Airport" => "HKG",
                 "Charles de Gaulle Airport" => "CDG",
                 "Frankfurt Airport" => "FRA" }
airport_data.each do |name, code|
  Airport.create!(name: name, code: code)
end

# Flights
Flight.delete_all
1000.times do
  from, to = (1..10).to_a.sample, (1..10).to_a.sample
  unless from == to
    random_date = Date.today + rand(5) + (0..24).to_a.sample.hours + (0..59).to_a.sample.minutes
    random_hours = "#{rand(15).to_s.rjust(2, '0')}"
    random_minutes = "#{rand(59).to_s.rjust(2, '0')}"
    Flight.create!(from_airport_id: from, to_airport_id: to, date: random_date,
                   duration: "#{random_hours}h#{random_minutes}m" )
  end
end
