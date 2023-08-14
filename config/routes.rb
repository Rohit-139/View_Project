Rails.application.routes.draw do

  root "users#welcome"


  resource :instructors, only: [:show, :new, :create,:edit, :update, :destroy]
  get 'instructors/welcome', to: "instructors#welcome"

  resources :programs
  get '/filter', to: 'programs#filter_on_status_basis'

  resource :customers, only: [:new, :show, :create, :destroy]
  get 'customers/welcome', to: 'customers#welcome'


  resources :enrolls
  get '/category_wise', to: 'enrolls#category_wise_courses'


  resource :users, only: [:destroy]
  get '/logout', to: 'users#logout'
  post'/login', to: 'users#login'
  get '/login_portal', to: 'users#login_portal'
  get '/choice', to: 'users#choice'
  post '/register', to: 'users#register'

end
