require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "98ca926ea2b9e22d701eb07810ad6059"

get "/" do
  # show a view that asks for the location
  view "ask"
end

get "/newsfeed" do
  # do everything else
    results = Geocoder.search(params["location"])
    @lat_long = results.first.coordinates # => [lat, long]
    @lat = @lat_long[0]
    @long = @lat_long[1]
    @location = params["location"]

    @forecast = ForecastIO.forecast(@lat, @long)

  view "newsfeed"
end