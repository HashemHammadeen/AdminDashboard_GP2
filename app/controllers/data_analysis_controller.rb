class DataAnalysisController < ApplicationController
  before_action :authenticate_any_admin!
  layout "dashboard"

  def index
    # 1. SCOPING: Isolate data depending on Admin Type
    if current_mall_admin
      @shops = current_mall.shops
      @users = User.joins(user_points_balances: :user).distinct # simplified for system oversight
    elsif current_shop_admin
      @shops = Shop.where(id: current_shop.id)
    end

    # Common localized scopes
    shop_ids = @shops.pluck(:id)
    t_30_days_ago = 30.days.ago.beginning_of_day

    # 2. Points Velocity (Line Chart: Earned vs Redeemed by Day)
    @points_earned_by_day = EarnTransaction
      .where(shop_id: shop_ids, created_at: t_30_days_ago..Time.current)
      .group_by_day(:created_at)
      .sum(:points_earned)

    @points_redeemed_by_day = RedeemTransaction
      .where(shop_id: shop_ids, created_at: t_30_days_ago..Time.current)
      .group_by_day(:created_at)
      .sum(:points_used)

    @points_velocity_data = [
      { name: "Points Issued", data: @points_earned_by_day },
      { name: "Points Burned", data: @points_redeemed_by_day }
    ]

    # 3. Daily Redemptions (Column Chart: Which day of the week is busiest?)
    @redemptions_by_day_of_week = RedeemTransaction
      .where(shop_id: shop_ids)
      .group_by_day_of_week(:created_at, format: "%A")
      .count

    # 4. Tier Distribution (Pie Chart) - Global for Mall Admin, Localized for Shop Admin
    if current_mall_admin
      @tier_distribution = User.joins(:tier).group("tiers.tier_name").count
    else
      # For shop admins, we look at users who have interacted with this specific shop
      local_user_ids = EarnTransaction.where(shop_id: shop_ids).select(:user_id)
      @tier_distribution = User.where(id: local_user_ids).joins(:tier).group("tiers.tier_name").count
    end

    # 5. Engagement/Activity (Area Chart: Active vs Inactive over last week)
    t_7_days_ago = 7.days.ago.beginning_of_day
    
    if current_mall_admin
      total_users = User.count
      active_users = EarnTransaction.where(created_at: t_7_days_ago..Time.current).distinct.count(:user_id)
    else
      total_users = EarnTransaction.where(shop_id: shop_ids).distinct.count(:user_id) # total ever seen
      active_users = EarnTransaction.where(shop_id: shop_ids, created_at: t_7_days_ago..Time.current).distinct.count(:user_id)
    end
    
    inactive_users = [total_users - active_users, 0].max
    @user_activity_data = {
      "Active (Last 7 Days)" => active_users,
      "Inactive" => inactive_users
    }

    # 6. Top Customers
    if current_mall_admin
      # Mall Admins care about highest overall point balances
      @top_customers = User.joins(:user_points_balance)
                           .order("user_points_balances.total_points DESC")
                           .limit(5)
      
      @top_customer_metric_name = "Point Balance"
      @top_customer_metric_method = ->(u) { u.user_points_balance&.total_points || 0 }
    else
      # Shop Admins care about who spends the most points in *their* shop
      top_user_ids_with_sums = RedeemTransaction
                               .where(shop_id: shop_ids)
                               .group(:user_id)
                               .order("sum_points_used DESC")
                               .limit(5)
                               .sum(:points_used)
      
      # eager load users to avoid N+1 and keep sort order
      users_map = User.where(id: top_user_ids_with_sums.keys).index_by(&:id)
      @top_customers = top_user_ids_with_sums.keys.map { |id| users_map[id] }.compact

      @top_customer_metric_name = "Points Spent Here"
      @top_customer_metric_method = ->(u) { top_user_ids_with_sums[u.id] || 0 }
    end
  end
end
