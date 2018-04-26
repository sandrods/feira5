Rails.application.routes.draw do

  resources :tipos
  resources :linhas
  resources :tamanhos
  resources :cores
  root 'cores#index'

  resources :produtos do
    get :lucro, on: :collection
    resources :etiquetas
  end

  resources :vendas do
    resources :itens, controller: 'vendas/itens'
    resources :registros, controller: 'vendas/registros'
    get 'mensal', on: :collection
  end

  resources :compras do
    resources :itens, controller: 'compras/itens'
    resources :registros, controller: 'compras/registros'
  end

  resources :ajustes do
    resources :itens, controller: 'ajustes/itens'
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
