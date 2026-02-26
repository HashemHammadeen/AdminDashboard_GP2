class MallDashboardsController < ApplicationController
  before_action :authenticate_mall_admin!
  layout "dashboard"

  def index
    @mall = current_mall_admin.mall

    # Global metrics
    @total_malls = Mall.count
    @total_shops = Shop.count
    @total_users = User.count
    @total_earn_transactions = EarnTransaction.count
    @total_points_earned = EarnTransaction.sum(:points_earned)
    @total_receipts = Receipt.count
    @pending_receipts = Receipt.where(status: "pending").count
    @active_offers = Offer.where(active: true).count

    # System config
    @system_config = SystemConfig.last

    # Lists
    @malls = Mall.all.limit(10)
    @shops = Shop.includes(:mall, :category).limit(10)
    @audit_logs = AuditLog.order(created_at: :desc).limit(20)
  end

  def show
    @mall = current_mall_admin.mall
  end
end