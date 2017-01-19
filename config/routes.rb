Rails.application.routes.draw do

  devise_for :users

  get 'wikis/index'

  get 'wikis/about'

  get 'welcome/landing'

  root 'welcome#landing'

end
