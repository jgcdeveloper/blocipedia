Rails.application.routes.draw do

  devise_for :users

  get 'welcome/index'

  get 'welcome/landing'

  get 'welcome/about'

  root 'welcome#landing'

end
