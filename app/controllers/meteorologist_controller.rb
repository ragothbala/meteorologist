require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    address_no_space=@street_address.gsub(' ','+')

url = "http://maps.googleapis.com/maps/api/geocode/json?address=" + address_no_space
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)

latitude1 = parsed_data["results"][0]["geometry"]["location"]["lat"]
longitude1 = parsed_data["results"][0]["geometry"]["location"]["lng"]
latitude2 = latitude1.to_f.round(3)
longitude2 = longitude1.to_f.round(3)

url2 = "https://api.darksky.net/forecast/a1f196121faf1e01cf6dc6d419e5cc89/" + latitude2.to_s + "," + longitude2.to_s
raw_data2 = open(url2).read
parsed_data2 = JSON.parse(raw_data2)

    @current_temperature = parsed_data2["currently"]["temperature"]

    @current_summary = parsed_data2["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_data2["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_data2["hourly"]["summary"]

    @summary_of_next_several_days = parsed_data2["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
