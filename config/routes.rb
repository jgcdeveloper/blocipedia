Rails.application.routes.draw do

  devise_for :users

  resources :wikis

  get 'welcome/about'

  root 'welcome#landing'

end
