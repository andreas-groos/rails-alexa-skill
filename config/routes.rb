Rails.application.routes.draw do
  root 'content#index'
  get '/help', to: 'content#help', as: 'help'
  get '/privacy', to: 'content#privacy', as: 'privacy'
  get '/terms',to: 'content#terms', as: 'terms'

  post '/account/signup', to: 'user#create', as: 'create_user'
  post '/signin', to: 'session#create', as: 'signin'
  get '/signout', to: 'session#destroy', as: 'signout'

  post '/alexa' => 'alexa#ask', :as => 'alexa'

  resources :recipe

end
