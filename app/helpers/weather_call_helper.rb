# require 'open-uri'
# require 'net/http'

module WeatherCallHelper
    include HTTParty

    @API_KEY = '4e8f3c3664c51137dfbf9590317c4d42'
    # @weather_api = "api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@API_KEY}" #open weather API
    def get_weather(lat, long)
        # uri = URI("api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&appid=#{@API_KEY}")
        # res = Net::HTTP.get_response(uri)

        res = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{long}&appid=#{@API_KEY}")
        if res.code == 200
            return true, res.body
        else
            return false, res.code
        end
    end
end