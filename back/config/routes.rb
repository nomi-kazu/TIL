Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resource :passwords, only: [:update]
      responses :relationships, param: 'follow_id', only: %i[create destroy]
      resources :posts, except: [:new]
      resources :users, except: [:edit] do
        get :current_user, action: :login_user, on: :collection
      end
      # ログイン・ログアウト処理
      resources :user_token, only: [:create] do
        delete :destroy, on: :collection
      end
    end
  end
end
