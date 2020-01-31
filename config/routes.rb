Rails.application.routes.draw do
    # so we can see followers and following
    # results: localhost:3000/user/1/following -> shows all User1's following (who the follow)
    resources :users do
        member do
            get :following, :followers
    end
end
    resources :microposts, only: [:create, :destroy] # we are not able to create and delete microposts
    resources :sessions, only: [:new, :create, :destroy]
    resources :relationships, only: [:create, :destroy]
    root 'static_pages#home'

    # static pages
    get '/about', to: 'static_pages#about'
    get '/contact', to: 'static_pages#contact'
    # Users
    get '/signup', to:'users#new'
    # Login and logout index
    get '/login', to:'sessions#new'
    delete '/logout', to: 'sessions#destroy'
end
