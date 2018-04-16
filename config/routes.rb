Rails.application.routes.draw do
  resources :floors do
    resources :areas
  end
end
