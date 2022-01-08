require 'date'

class WeatherAccountingJob < ApplicationJob
  include WeatherCallHelper
  queue_as :default

  def perform(id)
    if ClientWeatherDatum.find_by(id: id).counter != 0
      x = reschedule_job(id)
      # do_work(x)
    else
      # do_work(id)
      # call_validation(id) #call validation for the policy
    end
  end

  def do_work(id)
    #get cwd
    cwd = ClientWeatherDatum.find_by(id: id)
    lat, long = cwd.geo_location.split(',')[0], cwd.geo_location.split(',')[1]
    response = get_weather(lat, long)
    puts ([response[1].to_s, Date.today].join(":")) #{:Location=>"Thika", :Main=>"Clouds", :Desc=>"overcast clouds", :Temp_Avg=>25.62, :Temp_Max=>26.54, :Temp_Min=>25.62, :Rain=>0.0}
    
    data = "[" + [response[1].to_s, Date.today].join(":") + "] ,,"
    if cwd.weather_data == nil
      puts "ATTEMPTED UPDATE: #{cwd.update(weather_data:  data)}"
    else
      puts "ATTEMPTED UPDATE: #{cwd.update(weather_data: cwd.weather_data + data )}"
    end
    cwd.update(counter: cwd.counter-1)
    puts "COUNTER :: #{cwd.counter}"
  end

  def reschedule_job(id)
    self.class.set(wait: 3.hours).perform_later(id)
    return id
  end
end