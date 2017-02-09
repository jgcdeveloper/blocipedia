Rails.application.routes.draw do

  devise_for :users, controllers: { :registrations => 'users/registrations'}

  devise_scope :user do
    post "users/downgrade", :to => 'users/registrations#downgrade'
  end

  resources :wikis

  resources :charges, only: [:new, :create]

  get 'welcome/about'

  root 'welcome#landing'

end
