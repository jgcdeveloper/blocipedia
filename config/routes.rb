Rails.application.routes.draw do

  devise_for :users

  get 'wikis/index'

  get 'welcome/about'

  get 'welcome/landing'

  root 'welcome#landing'

end
