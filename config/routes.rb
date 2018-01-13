Rails.application.routes.draw do
  namespace :zolna_embed_pages do
    get 'last'
  end
  resources :zolna_embed_pages do
    member do
      get 'next'
      post 'post_to_steemit'
      post 'skip_posting'
      post 'favorite'
    end
  end

  resources :videos, only: [:show]
  resources :sessions
end
