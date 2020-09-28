Rails.application.routes.draw do
  root 'event#index'
  get 'event/index'
  post 'event/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
