Rails.application.routes.draw do
  # Custom session routes (replaces Devise for mall_admins and shop_admins)
  scope module: "mall_admins" do
    get  "mall_admins/login",  to: "sessions#new",     as: :mall_admin_login
    post "mall_admins/login",  to: "sessions#create"
    delete "mall_admins/logout", to: "sessions#destroy", as: :mall_admin_logout
  end

  scope module: "shop_admins" do
    get  "shop_admins/login",  to: "sessions#new",     as: :shop_admin_login
    post "shop_admins/login",  to: "sessions#create"
    delete "shop_admins/logout", to: "sessions#destroy", as: :shop_admin_logout
  end

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
  resources :offers
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
  get "mall_admin_root", to: "mall_dashboards#index", as: :mall_admin_root
  get "shop_admin_root", to: "shop_dashboards#index", as: :shop_admin_root

  root to: "home#index"

  # Data Analysis
  get "data_analysis", to: "data_analysis#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
