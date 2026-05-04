class ShopDashboardsController < ApplicationController
  before_action :authenticate_shop_admin!
  layout "dashboard"

  def index
    shop = current_shop

    # Shop-scoped stats
    @shop = shop
    @total_earn_transactions = shop ? EarnTransaction.where(shop_id: shop.id).count : 0
    @total_points_earned = shop ? EarnTransaction.where(shop_id: shop.id).sum(:points_earned) : 0
    @total_redeem_transactions = shop ? RedeemTransaction.where(shop_id: shop.id).count : 0
    @total_receipts = shop ? Receipt.where(shop_id: shop.id).count : 0
    @pending_receipts = shop ? Receipt.where(shop_id: shop.id, status: :pending).count : 0
    @total_offers = shop ? Offer.where(shop_id: shop.id).count : 0
    @active_offers = shop ? Offer.where(shop_id: shop.id, is_active: true).count : 0
    @total_stamps = shop ? Stamp.where(shop_id: shop.id).count : 0
    @total_qrs = shop ? Qr.where(shop_id: shop.id).count : 0

    # Recent data
    @recent_earn_transactions = shop ? EarnTransaction.where(shop_id: shop.id).includes(:user).order(created_at: :desc).limit(5) : EarnTransaction.none
    @recent_receipts = shop ? Receipt.where(shop_id: shop.id).includes(:user).order(created_at: :desc).limit(5) : Receipt.none
    @recent_redeem_transactions = shop ? RedeemTransaction.where(shop_id: shop.id).includes(:user).order(created_at: :desc).limit(5) : RedeemTransaction.none
  end

  def show
    redirect_to shop_dashboards_path
  end
end