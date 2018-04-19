Rails.application.routes.draw do
  resources :floors do
    resources :areas
    resources :cameras, only: [:index, :show]
  end


  resources :areas, only: [:index, :show] do
    resources :cameras
  end

  resources :cameras, only: [:index, :show]
  
  resources :event_types, :sensor_types, :settings, :events, :sensors
end
