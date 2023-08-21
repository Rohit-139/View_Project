Rails.application.routes.draw do

  root "users#login_portal"


  resources :instructors, only: [:show, :new, :create,:edit, :update, :destroy]
  get 'instructors_welcome', to: "instructors#welcome"

  resources :programs
  get '/filter', to: 'programs#filter_on_status_basis'

  resources :customers
  get 'customers_welcome', to: 'customers#welcome'

  resources :enrolls, only: [:index, :show, :create, :edit, :update, :destroy]
  get '/category_wise', to: 'enrolls#category_wise_courses'
  get '/new/:id', to: 'enrolls#new_enroll'

  resource :users, only: [:destroy]
  get '/logout', to: 'users#logout'
  post'/login', to: 'users#login'
  get '/login_portal', to: 'users#login_portal'
  get '/choice', to: 'users#choice'
  post '/register', to: 'users#register'
  get '/password', to: 'users#password'
  post '/change_password', to: 'users#change_password'

end
