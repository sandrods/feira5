Rails.application.routes.draw do

  resources :tipos
  resources :linhas
  resources :tamanhos
  resources :cores

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

  resources :estoque

  get  'etiquetas' => 'etiquetas#index', as: 'etiquetas'
  post 'etiquetas' => 'etiquetas#print', as: 'print_etiquetas'
  post 'etiquetas/:id/select'   => 'etiquetas#select',       as: 'select_etiqueta'
  post 'etiquetas/:id/unselect' => 'etiquetas#unselect',     as: 'unselect_etiqueta'
  post 'etiquetas/unselect'     => 'etiquetas#unselect_all', as: 'unselect_all_etiquetas'
  post 'etiquetas/select'       => 'etiquetas#select_page',  as: 'select_page_etiquetas'

  resources :fornecedores do
    post :arquivar, on: :member
  end

  resources :clientes do
    post :arquivar, on: :member
  end

  resources :colecoes

  resources :compras do
    resources :itens, controller: 'compras/itens'
    resources :registros, controller: 'compras/registros'
  end

  resources :sacolas do
    resources :itens, controller: 'itens_sacola' do
      post 'devolver', on: :collection
    end
    get 'print', on: :member
  end

  resources :vendas do
    resources :itens, controller: 'vendas/itens'
    resources :registros, controller: 'vendas/registros'
    get 'mensal', on: :collection
  end

  get 'financeiro/diario'
  get 'financeiro/anual'

  resources :registros do
    post :duplicate, on: :member
  end
  resources :transferencias, controller: 'registros/transferencias'

  resources :contas
  resources :categorias
  resources :formas

  get 'dashboard/index'
  root 'clientes#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
