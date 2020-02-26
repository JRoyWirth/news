require "sinatra"
require "sinatra/reloader"
require "geocoder"
require "forecast_io"
require "httparty"
def view(template); erb template.to_sym; end
before { puts "Parameters: #{params}" }                                     

# enter your Dark Sky API key here
ForecastIO.api_key = "98ca926ea2b9e22d701eb07810ad6059"

require 'open-uri'
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=03a659223c4e4c738b04bbf78cf5403a"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

get "/" do
  # show a view that asks for the location
  view "ask"
end

# enter your Dark Sky API key here
ForecastIO.api_key = "98ca926ea2b9e22d701eb07810ad6059"

require 'open-uri'
url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=03a659223c4e4c738b04bbf78cf5403a"
news = HTTParty.get(url).parsed_response.to_hash
# news is now a Hash you can pretty print (pp) and parse for your output

get "/newsfeed" do
  # do weather
    results = Geocoder.search(params["location"])
    @lat_long = results.first.coordinates # => [lat, long]
    @lat = @lat_long[0]
    @long = @lat_long[1]
    @location = params["location"]

    @forecast = ForecastIO.forecast(@lat, @long)
  
    @daily = @forecast['daily']['data']

  # do news
    req = open(url)
    @response_body = news
    @news_array = @response_body['articles']     

  view "newsfeed"
end