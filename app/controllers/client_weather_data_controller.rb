class ClientWeatherDataController < ApplicationController
    include WeatherCallHelper
    
    def create
        client = ClientWeatherDatum.new(client_params)
        if client.valid?
            client.save
            render json: {status: "SUCCESS", message: "new client created", data: client}, status: :ok
        else
            render json: {status: "FAILURE", message: "Failed to Create New Client", data: client.errors}, status: :unprocessable_entity
        end
    end

    def update
        #run the update everyday. 
        client = ClientWeatherDatum.find_by(name: params[:name])
        weather = {}
        latitude = client.geo_location.split(',')[0]
        longitude = client.geo_location.split(',')[1]
        res = get_weather(latitude, longitude) #call weather API & input data in to array
        if res[0] 
            weather << {Date.today => res} 
            client.weather_data << weather
            if client.valid?
                client.save
                render json: {status: "SUCCESS", message: "Got Weather for #{Date.today}", data: client}, status: :ok
            end
        else
            render json: {status: "FAILURE", message: "Failed to get weather for #{Date.today} && #{res[1]}"}, status: :unprocessable_entity
        end
    end

    def destroy
    end

    def show
    end

    private
        def client_params
            params.permit(:name, :geo_location, :start_date, :end_date)
            # { POST
            #     "name": "Kamau John",
            #     "geo_location": "-1.0916910437520184, 37.01157644647871",
            #     "start_date": "2021-10-06",
            #     "end_date": "2021-10-08"
            # }
        end

        def update_params
            params.permit(:name)
            # {   PUT
            #     "name": "Kamau John",
            #     "weather_data": "{
            #         "asdlf": "asdlkfj"
            #       }"
            # }
        end
end
