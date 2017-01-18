Rails.application.routes.draw do

  get 'welcome/index'

  get 'welcome/signup'

  get 'welcome/about'

  root 'welcome#signup'

end
