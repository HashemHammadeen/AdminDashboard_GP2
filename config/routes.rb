Rails.application.routes.draw do
  devise_for :mall_admins, controllers: { sessions: 'mall_admins/sessions' }
  devise_for :shop_admins, controllers: { sessions: 'shop_admins/sessions' }, skip: [:registrations]

  # Dashboard routes
  resources :mall_dashboards, only: [:index]
  resource :mall_dashboard, only: [:show]
  resources :shop_dashboards, only: [:index]
  resource :shop_dashboard, only: [:show]

  # Mall Admin resources
  resources :malls
  resources :shops do
    member do
      patch :approve
      patch :deactivate
    end
  end
  resources :users
  resources :categories
  resources :tiers
  resources :system_configs, only: [:index, :show, :edit, :update]
  resources :mall_admins
  resources :user_points_balances, only: [:index, :show, :edit, :update]
  resources :audit_logs, only: [:index, :show]

  # Shop Admin resources
  resources :earn_transactions
  resources :redeem_transactions
  resources :receipts
  resources :offers do
    member do
      patch :request_reactivation
      patch :approve_reactivation
      patch :deny_reactivation
    end
  end
  resources :stamps
  resources :stamp_transactions, only: [:index, :show]
  resources :offer_redemptions, only: [:index, :show]
  resources :user_stamp_cards, only: [:index, :show, :new, :create]
  resources :qrs
  resources :shop_admins, only: [:index, :show, :edit, :update, :new, :create] do
    member do
      patch :toggle_active
    end
  end

  # Dashboard Routing Logic
  authenticated :mall_admin do
    root to: "mall_dashboards#index", as: :mall_admin_root
  end

  authenticated :shop_admin do
    root to: "shop_dashboards#index", as: :shop_admin_root
  end

  root to: "home#index"

  # Data Analysis
  get "data_analysis", to: "data_analysis#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
