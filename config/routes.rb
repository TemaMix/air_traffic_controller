Rails.application.routes.draw do
  root 'planes#index'

  mount ActionCable.server => "/cable"


  namespace :api do
    put 'planes/state/:id', to: 'plane_state#update'
    resources :planes, only: [:create]
  end

end
