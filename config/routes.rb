Rails.application.routes.draw do
  
  get 'profile/edit_profile'
  post 'profile/edit_profile'

  root "account#create_account"
  get '/signup', to: 'account#create_account'
  post '/signup', to: 'account#create_account'
  
  get '/login', to: 'account#login'
  post '/login', to: 'account#login'
  
  get '/dashboard/:id', to: 'account#dashboard', as: 'dashboard'
  get '/logout', to: 'account#logout'

  
  get 'password/forgot_password', as: "forgot_password"
  post 'password/forgot_password'
  
  get 'password/reset_password', as: 'reset_password'
  post 'password/reset_password'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
