Rails.application.routes.draw do
  resources :floors do
    resources :areas
    resources :cameras, only: [:index, :show]
    resources :sensors, only: [:index, :show]
  end

  resources :areas, only: [:index, :show] do
    resources :cameras, :sensors
  end

  resources :sensor_types do
    resources :sensors, only: [:index, :show]
  end

  resources :cameras, only: [:index, :show]
  resources :sensors, only: [:index, :show]
  
  resources :event_types, :settings, :events
end
