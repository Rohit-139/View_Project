Rails.application.routes.draw do

  root "users#welcome"
  post'/login', to: 'users#login'
  get '/login_portal', to: 'users#login_portal'

  resource :instructors, only: [:new, :create, :destroy]
  resources :programs
  resource :customers, only: [:show, :create, :destroy]
  get '/welcome', to: 'customers#welcome'
  resources :enrolls
  resource :users, only: [:destroy]

  get '/filter', to: 'programs#filter_on_status_basis'
  get '/category_wise', to: 'enrolls#category_wise_courses'

end
