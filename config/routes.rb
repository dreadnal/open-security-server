Rails.application.routes.draw do
  resources :floors do
    resources :areas
  end
  
  resources :event_types
  resources :sensor_types
  resources :settings
  resources :cameras
  resources :events
  resources :sensors
end
