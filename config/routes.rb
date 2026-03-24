Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products
    end
  end
  post 'login', to: 'api/v1/auth#login'
  post 'signup', to: 'api/v1/auth#signup'
  post 'payments', to: 'api/v1/payments#create'
end