Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :top, only: [:index] do
        get :exp_ranking, on: :collection
      end
      resources :admin do
        get :users, on: :collection
        get :posts, on: :collection
        get :comments, on: :collection
        get :tags, on: :collection
      end
      resource :passwords, only: [:update]
      resources :relationships, param: 'follow_id', only: %i[create destroy]
      resources :posts, except: [:new]
      resources :tags, only: %i[show create destroy] do
        delete :delete_tag
      end
      resources :likes, only: %i[create destroy]
      resources :comments, only: %i[create destroy]
      resources :users, except: [:edit]
      resources :search do
        get :users,  on: :collection
        get :posts,  on: :collection
        get :tags,   on: :collection
      end
      resources :notices, only: [:index]
      resource :setting, only: %i[edit update]
      get '/notices/unchecked', to: 'notices#unchecked'
      get '/notices/checked', to: 'notices#checked'
      # ログイン/ログアウト処理
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
