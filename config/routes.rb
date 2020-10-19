Rails.application.routes.draw do
  
  root 'sessions#new'
  post 'extratos', to: 'extratos#index'
  post 'saldo', to: 'users#saldo'
  post 'saque', to: 'users#saque'
  post 'calculo', to: 'users#calculo'
  post 'deposito', to: 'users#deposito'
  post 'calculodeposito', to: 'users#calculoDeposito'
  post 'transferencia', to: 'users#transferencia'
  post 'calculotransferencia', to: 'users#calculoTransferencia'
  post 'efetuatransferencia', to: 'users#efetuaTransferencia'
  get 'entrar', to: 'sessions#new'
  post 'entrar', to: 'sessions#create'
  delete 'sair', to: 'sessions#destroy'
  post 'clientes', to: 'users#clientes'
  resources :users
  #resources :move
  #resources :extratos

end
