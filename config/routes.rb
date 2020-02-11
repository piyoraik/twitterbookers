Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'homes#index'
  get '/top' => 'homes#top'
  get 'auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
end
