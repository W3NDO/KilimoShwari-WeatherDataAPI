require 'open-uri'
require 'net/http'

module WeatherCallHelper
    # include HTTParty

    @API_KEY = 'ce3a3d9423215ed4e8ca858aa94a7941'
    # @weather_api = "api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&appid=#{@API_KEY}" #open weather API
    def get_weather(lat, long)
        lat = lat.to_s[0..5]
        long = long.to_s[0..5] 
        url = "http://api.openweathermap.org/data/2.5/weather?lat="+lat+"&lon="+long+"&appid=ce3a3d9423215ed4e8ca858aa94a7941&units=metric".to_s
        res = HTTParty.get(url)
        # res = HTTParty.get("http://api.openweathermap.org/data/2.5/weather?lat=-1.09&lon=37.01&appid=ce3a3d9423215ed4e8ca858aa94a7941")
        if res.code == 200
            res = res.parsed_response
            puts "STH::: #{res["weather"][0]["main"]}"
               
            content = Hash.new
            content[:Location] = res["name"]
            content[:Main] = res["weather"][0]["main"]
            content[:Desc] = res["weather"][0]["description"]
            content[:Temp_Avg] = res["main"]["temp"]
            content[:Temp_Max] = res["main"]["temp_max"]
            content[:Temp_Min] = res["main"]["temp_min"]
            
            content[:Rain] = res["rain"]["1h"] if res.include?("rain")
            return true, content, url
        else
            return false, res.code, url
        end
    end
end

# http://api.openweathermap.org/data/2.5/weather?lat=-1.091&lon=37.011&appid=ce3a3d9423215ed4e8ca858aa94a7941&units=metric