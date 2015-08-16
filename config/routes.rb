Rails.application.routes.draw do
  # root 'static_pages#home'

  # sessions
  get 'logout'     => 'sessions#destroy'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  get 'categories/list' => 'subscriptions#list'
  get 'categories/subscribed' => 'subscriptions#subscribed'
  put 'categories/subscribe'  => 'subscriptions#subscribe'

  get 'categories/recommend_drink' =>  'categories#recommend_drink'

  get 'drinks/top' => 'drinks#top'
  put 'drinks/like' => 'drinks#like'
  put 'drinks/dislike' => 'drinks#dislike' 

  #DEBUG
  get    'login'   => 'sessions#create'
  get    'categories/subscribe'   => 'subscriptions#subscribe'
  get	 'drinks/like' => 'drinks#like'
  get	 'drinks/dislike' => 'drinks#dislike' 
end
