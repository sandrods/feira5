Rails.application.routes.draw do

  resources :tipos
  resources :linhas
  resources :tamanhos
  resources :cores
  root 'cores#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
