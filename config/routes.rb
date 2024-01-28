Rails.application.routes.draw do

  root :to => 'homes#top'

# 管理者
  devise_for :admin, controllers: {
    sessions: "admin/sessions"
  }

# 先生
  devise_for :teacher, controllers: {
    registrations: "teacher/registrations",
    sessions: 'teacher/sessions'
  }
  
  devise_scope :teacher do
    post 'teacher/guest_sign_in' => 'teacher/sessions#guest_sign_in'
  end
  


# 生徒
  devise_for :student, controllers: {
    registrations: "student/registrations",
    sessions: 'student/sessions'
  }

  devise_scope :student do
    post 'student/guest_sign_in' => 'student/sessions#guest_sign_in'
  end


  namespace :teacher do
# トップページ
    root to: 'homes#top'
# 投稿機能
    resources :posts, only: [:index, :new, :create, :show, :edit, :update]
# マイページ
    patch '/customers/withdraw' => 'customers#destroy'
    get '/customers/withdraw' => 'customers#withdraw'
    resource :customers, only:[:show,:edit,:update]

# いいね機能
    resource :favorites, only: [:create, :destroy]

# DM機能
    resources :messages, :only => [:create]
    resources :rooms, :only => [:show]

# 申込み画面
    resources :lessons, only: [:index, :show, :update]
  end


  namespace :student do
# トップ
    root to: 'homes#top'
# 投稿機能
    get 'search' => 'posts#search'
    resources :posts, only: [:index, :show] do
      resource :favorites, only: [:create, :destroy]
    end
    resources :favorite_lists, only: [:index]
# マイページ
    patch '/customers/withdraw' => 'customers#destroy'
    get '/customers/withdraw' => 'customers#withdraw'
    resource :customers, only:[:show,:edit,:update]
# DM機能
    resources :messages, :only => [:create]
    resources :rooms, :only => [:create, :show]
# 申込み画面
    get '/lessons/confirm/:post_id' => 'lessons#confirm', as: :confirm
    get  '/lessons/complete'=>'lessons#complete', as: :complete
    resources :lessons, only:[:new,:create,:index,:show]
  end


  namespace :admin do
    root to: 'homes#top'
    resources :customer_teachers, only: [:index, :show, :edit, :update]
    resources :customer_students, only: [:index, :show, :edit, :update]
  end

end