require 'date'

def perform(id)
    



    1.minute do
        cwd = ClientWeatherDatum.find_by(id: id) #get the client weather data
        lat = cwd.geo_location.split(',')[0]
        long = cwd.geo_location.split(',')[1]
        res = get_weather(lat, long) #make the API call
        if res
        puts "Getting Weather"
        res = JSON.parse res[1].gsub("=>",":") #parse the response content as a hash
        weather_data = {} #initialize a new hash
        if !cwd.weather_data
            weather_data = JSON.parse cwd.weather_data.gsub("=>",":") #parse the weather data in the db
            weather_data[daily_temp] += "," + res["Temp_Avg"].to_s #add daily temp
            weather_data[daily_rain] += "," + res["Rain"].to_s #add daily rain
            cwd.weather_data = weather_data.to_s #add weather data to the db as a string
        else 
            weather_data[daily_temp] += "," + res["Temp_Avg"].to_s #add daily temp
            weather_data[daily_rain] += "," + res["Rain"].to_s #add daily rain
            cwd.weather_data = weather_data.to_s #add weather data to the db as a string
        end

        Async do |task|
            task.async do
            cwd.save
            end
        end
        else
        puts "couldn't get weather from job"
        end
    end
end

def date()
    @year = Date.today.year
    puts @year
    start = Time.at(1640574886)
    fin = Time.at(1635304486)
    puts start.wday

    total_num_of_days = (start.to_date - fin.to_date).to_i
    # total_num_of_weeks = (start.strftime("%W") - fin.strftime("%W")).to_i

    puts total_num_of_days
    puts start
end

date()


