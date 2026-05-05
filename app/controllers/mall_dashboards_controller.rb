class MallDashboardsController < ApplicationController
  before_action :authenticate_mall_admin!
  layout "dashboard"

  def index
    mall = current_mall

    # Global stats scoped to this mall
    @total_malls = 1  # Their own mall
    @total_shops = mall ? Shop.where(mall_id: mall.id).count : 0
    @active_shops = mall ? Shop.where(mall_id: mall.id, is_active: true).count : 0
    @pending_shops = mall ? Shop.where(mall_id: mall.id, is_active: false).count : 0
    @total_users = User.count
    @total_categories = Category.where(mall_id: mall.id).count

    # Transaction stats for shops in this mall
    mall_shop_ids = mall ? Shop.where(mall_id: mall.id).pluck(:shop_id) : []
    @total_earn_transactions = EarnTransaction.where(shop_id: mall_shop_ids).count
    @total_points_earned = EarnTransaction.where(shop_id: mall_shop_ids).sum(:points_earned)
    @total_receipts = Receipt.where(shop_id: mall_shop_ids).count
    @pending_receipts = Receipt.where(shop_id: mall_shop_ids, status: :pending).count
    @total_offers = Offer.where(shop_id: mall_shop_ids).count
    @active_offers = Offer.where(shop_id: mall_shop_ids, is_active: true).count

    # Recent data
    @recent_shops = mall ? Shop.where(mall_id: mall.id).order(created_at: :desc).limit(5) : Shop.none
    @recent_transactions = EarnTransaction.where(shop_id: mall_shop_ids).includes(:user, :shop).order(created_at: :desc).limit(5)
    @recent_receipts = Receipt.where(shop_id: mall_shop_ids).includes(:user, :shop).order(created_at: :desc).limit(5)

    # System config (mall-scoped)
    @system_config = SystemConfig.find_by(mall_id: mall.id)

    # Audit logs
    @recent_audit_logs = AuditLog.order(created_at: :desc).limit(5)
  end

  def show
    redirect_to mall_dashboards_path
  end
end