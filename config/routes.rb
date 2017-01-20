Rails.application.routes.draw do

  devise_for :users

#  get 'wikis/index'

  resources :wikis

  get 'welcome/about'

  root 'welcome#landing'

end
