Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/auth/login', to: 'authentication#login'

  namespace :api do
    scope ':version' do # use scope so we dynamically add support for different api versions
      resources :users, only: [:create, :update]
    end
  end
end
