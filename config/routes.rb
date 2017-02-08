Rails.application.routes.draw do

  devise_for :users

  resources :wikis

  resources :charges, only: [:new, :create]

  get 'welcome/about'

  root 'welcome#landing'

end
