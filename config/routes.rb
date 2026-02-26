Rails.application.routes.draw do
  devise_for :mall_admins
  devise_for :shop_admins

  # Dashboard routes
  resources :mall_dashboards, only: [:index]
  resource :mall_dashboard, only: [:show]
  resources :shop_dashboards, only: [:index]
  resource :shop_dashboard, only: [:show]

  # Mall Admin resources
  resources :malls
  resources :shops
  resources :users
  resources :categories
  resources :tiers
  resources :system_configs
  resources :mall_admins
  resources :user_points_balances
  resources :audit_logs, only: [:index, :show]

  # Shop Admin resources
  resources :earn_transactions
  resources :redeem_transactions
  resources :receipts
  resources :offers
  resources :stamps
  resources :stamp_transactions
  resources :offer_redemptions
  resources :user_stamp_cards
  resources :qrs
  resources :shop_admins

  # Dashboard Routing Logic
  authenticated :mall_admin do
    root to: "mall_dashboards#index", as: :mall_admin_root
  end

  authenticated :shop_admin do
    root to: "shop_dashboards#index", as: :shop_admin_root
  end

  root to: "home#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
