Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: 'registrations'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resource :client_weather_data
      resource :policies, :only => [:create]
      resource :contracts

      post :auth, to: 'authentication#create'
      get '/auth' => 'authentication#fetch'
      
      delete '/policies/:id' => 'policies#destroy'
      get '/policies' => 'policies#index'
      put 'policies/:id' => 'policies#edit'
      patch 'policies/:id' => 'policies#edit'
      get 'singlePolicy/:id' => 'policies#show'
    end
  end
end