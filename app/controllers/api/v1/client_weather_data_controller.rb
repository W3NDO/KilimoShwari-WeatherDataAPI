class Api::V1::ClientWeatherDataController < ApiController
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
        weather = []
        latitude = client.geo_location.split(',')[0]
        longitude = client.geo_location.split(',')[1]
        res = get_weather(latitude, longitude) #call weather API & input data in to array
        if res[0] 
            weather << {Date.today => res[1].to_s} 
            client.weather_data = client.weather_data + "," + weather.to_s
            if client.valid?
                client.save
                render json: {status: "SUCCESS", message: "Got Weather for #{Date.today}, :: #{res[2]}", data: client}, status: :ok
            end
        else
            render json: {status: "FAILURE", message: "Failed to get weather for #{Date.today} && Error Code from OpenWeather: #{res[1]}, , :: #{res[2]}"}, status: :unprocessable_entity
        end
    end

    def destroy
    end

    def show
    end

    private
        def client_params
            params.permit(:name, :weather_data, :geo_location, :start_date, :end_date)
            # { POST
            #     "name": "Kamau John",
            #     "geo_location": "-1.0916910437520184,37.01157644647871", !!!! DO not put a space between the lat & long. Separate with comma only
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