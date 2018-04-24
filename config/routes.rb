Rails.application.routes.draw do
  resources :floors, only: [:index, :show] do # checked
    resources :areas, only: [:index, :show] # checked
    resources :cameras, only: [:index, :show] # checked
    resources :sensors, only: [:index, :show]
    resources :events, only: [:index, :show] do
      collection do
        get 'read'
        get 'unread'
      end
    end
    resources :event_types, only: [] do # checked
      resources :events, only: [:index] do
        collection do
          get 'read'
          get 'unread'
        end
      end
    end
  end

  resources :areas, only: [:index, :show] do # checked
    resources :cameras, only: [:index, :show] # checked
    resources :sensors
    resources :events, only: [:index, :show] do
      collection do
        get 'read'
        get 'unread'
      end
    end
    resources :event_types, only: [] do # checked
      resources :events, only: [:index] do
        collection do
          get 'read'
          get 'unread'
        end
      end
    end
  end

  resources :sensor_types, only: [:index, :show] do # checked
    resources :sensors, only: [:index, :show]
  end

  resources :sensors, only: [:index, :show] do
    resources :events do
      collection do
        get 'read'
        get 'unread'
      end
    end
  end

  resources :event_types, only: [:index, :show] do # checked
    resources :events, only: [:index, :show] do
      collection do
        get 'read'
        get 'unread'
      end
    end
  end

  resources :events, only: [:index, :show] do
    collection do
      get 'read'
      get 'unread'
    end
  end

  resources :cameras, only: [:index, :show] #checked
  
  resources :settings
end
