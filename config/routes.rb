Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registatrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :client_weather_data
      resource :policies
      resource :contracts

      post :auth, to: 'authentication#create'
      get '/auth' => 'authentication#fetch'
    end
  end
end