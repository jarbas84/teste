Rails.application.routes.draw do
  
  root 'sessions#new'
  post 'extratos', to: 'extratos#index'
  post 'saldo', to: 'move#saldo'
  post 'saque', to: 'move#saque'
  post 'calculo', to: 'move#calculo'
  post 'deposito', to: 'move#deposito'
  post 'calculodeposito', to: 'move#calculoDeposito'
  post 'transferencia', to: 'move#transferencia'
  post 'calculotransferencia', to: 'move#calculoTransferencia'
  post 'efetuatransferencia', to: 'move#efetuaTransferencia'
  get 'entrar', to: 'sessions#new'
  post 'entrar', to: 'sessions#create'
  delete 'sair', to: 'sessions#destroy'
  resources :users
  #resources :move
  #resources :extratos

end
