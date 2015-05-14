Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  root 'welcome#index'

  resources :events, only: [:create, :update]

  namespace :admin do
    get '/' => 'dashboard#index', as: :dashboard

    resources :projects, except: [:show, :new, :update] do
      collection do
        post :add_user
        patch :remove_user
      end
    end

    resources :users, except: [:new, :create] do
      collection do
        post :add_rate
      end

      member do
        get :event_table, controller: :events
      end
    end

    resources :reports, only: [:index]
  end
end
