Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/login', to: 'auth#login'
      get '/me', to: 'auth#me'
    end
  end
end
