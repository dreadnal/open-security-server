Rails.application.routes.draw do
  resources :floors, only: [:index, :show] do # checked
    resources :areas, only: [:index, :show] # checked
    resources :cameras, only: [:index, :show] # checked
    resources :sensors, only: [:index, :show] # checked
    resources :events, only: [:index, :show] do # checked
      collection do
        get 'read' #checked
        get 'unread' #checked
      end
    end
    resources :event_types, only: [] do # checked
      resources :events, only: [:index] do # checked
        collection do
          get 'read' # checked
          get 'unread' # checked
        end
      end
    end
  end

  resources :areas, only: [:index, :show] do # checked
    resources :cameras, only: [:index, :show] # checked
    resources :sensors, only: [:index, :show] # checked
    resources :events, only: [:index, :show] do # checked
      collection do
        get 'read' # checked
        get 'unread' # checked
      end
    end
    resources :event_types, only: [] do # checked
      resources :events, only: [:index] do # checked
        collection do
          get 'read' # checked
          get 'unread' # checked
        end
      end
    end
  end

  resources :sensor_types, only: [:index, :show] do # checked
    resources :sensors, only: [:index, :show] # checked
  end

  resources :sensors, only: [:index, :show] do # checked
    resources :events, only: [:index, :show, :create] do # checked
      collection do
        get 'read' # checked
        get 'unread' # checked
      end
    end
  end

  resources :event_types, only: [:index, :show] do # checked
    resources :events, only: [:index, :show] do # checked
      collection do
        get 'read' # checked
        get 'unread' # checked
      end
    end
  end

  resources :events, only: [:index, :show] do # checked
    collection do
      get 'read' # checked
      get 'unread' # checked
    end
  end

  resources :devices, only: [] do # checked
    member do
      post 'verify' # checked
    end
  end

  resources :cameras, only: [:index, :show] #checked
end
