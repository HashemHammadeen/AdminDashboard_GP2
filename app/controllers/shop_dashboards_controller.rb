class ShopDashboardsController < ApplicationController
  before_action :authenticate_shop_admin!
  layout "dashboard"

  def index
    @shop = current_shop_admin.shop

    # Shop-specific metrics
    @earn_transactions_count = @shop.earn_transactions.count
    @total_points_earned = @shop.earn_transactions.sum(:points_earned)
    @total_revenue = @shop.earn_transactions.sum(:purchase_amount)
    @redeem_transactions_count = @shop.redeem_transactions.count
    @offer_redemptions_count = OfferRedemption.where(shop_id: @shop.id).count
    @active_offers = @shop.offers.where(active: true).count
    @total_receipts = @shop.receipts.count
    @pending_receipts = @shop.receipts.where(status: "pending").count
    @stamp_cards_count = @shop.stamps.count
    @active_stamp_cards = @shop.stamps.where(active: true).count

    # Recent data
    @recent_earn_transactions = @shop.earn_transactions.order(created_at: :desc).limit(10)
    @recent_receipts = @shop.receipts.order(created_at: :desc).limit(10)
  end

  def show
    @shop = current_shop_admin.shop
  end
end