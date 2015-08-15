Rails.application.routes.draw do
  # root 'static_pages#home'

  # sessions
  get    'login'   => 'sessions#create'
  get 'logout'     => 'sessions#destroy'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
end
