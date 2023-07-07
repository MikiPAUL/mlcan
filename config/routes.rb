Rails.application.routes.draw do
  use_doorkeeper
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :admins, controllers: { 
    registrations: 'admin/registrations',
    sessions: 'admin/sessions',
    passwords: 'admin/passwords'
  }
end
