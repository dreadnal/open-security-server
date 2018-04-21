Rails.application.routes.draw do
  resources :floors do
    resources :areas
    resources :cameras, only: [:index, :show]
    resources :sensors, only: [:index, :show]
    resources :events, only: [:index, :show] do
      collection do
        get 'read'
        get 'unread'
      end
    end
    resources :event_types, only: [] do
      resources :events, only: [:index] do
        collection do
          get 'read'
          get 'unread'
        end
      end
    end
  end

  resources :areas, only: [:index, :show] do
    resources :cameras, :sensors
    resources :events do
      collection do
        get 'read'
        get 'unread'
      end
    end
    resources :event_types, only: [] do
      resources :events, only: [:index] do
        collection do
          get 'read'
          get 'unread'
        end
      end
    end
  end

  resources :sensor_types do
    resources :sensors, only: [:index, :show]
  end

  resources :sensors, only: [:index, :show] do
    resources :events, only: [:index, :show] do
      collection do
        get 'read'
        get 'unread'
      end
    end
  end

  resources :event_types do
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

  resources :cameras, only: [:index, :show]
  
  resources :settings
end
