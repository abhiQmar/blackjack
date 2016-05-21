Rails.application.routes.draw do
  root 'game#index'
  resources :game, :only => [] do
    collection do
      post 'hit'
      post 'stand'
      post 'start'
    end
  end
end
