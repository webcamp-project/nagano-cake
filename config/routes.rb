Rails.application.routes.draw do

  #会員側のルーティング設定
  scope module: :public do
    root to: "homes#top"
    get "/home/about" => "homes#about"
  end

  devise_for :customers, skip:[:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations'
  }

  #管理側のルーティング設定
  namespace :admin do
    get "/" => "homes#top"
    resources :genres, only:[:index, :create, :edit, :update]
    resources :items, only:[:new, :create, :index, :show, :edit, :update]
  end

  devise_for :admin, skip:[:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
