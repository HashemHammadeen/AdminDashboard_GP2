class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user # No permissions for unauthenticated

    if user.is_a?(MallAdmin)
      mall_admin_abilities(user)
    elsif user.is_a?(ShopAdmin)
      shop_admin_abilities(user)
    end
  end

  private

  def mall_admin_abilities(admin)
    mall_id = admin.mall_id

    # Mall management — only their own mall
    can [:read, :update, :destroy], Mall, mall_id: mall_id

    # Store management — shops in their mall
    can :manage, Shop, mall_id: mall_id

    # Categories & Tiers — global management
    can :manage, Category
    can :manage, Tier

    # System config — global
    can :manage, SystemConfig

    # Mall admin management — only admins in their mall
    can :manage, MallAdmin, mall_id: mall_id

    # Shop admin management — admins of shops in their mall
    can :manage, ShopAdmin, shop: { mall_id: mall_id }

    # User management — global (System Oversight)
    can :manage, User
    can :manage, UserPointsBalance

    # Audit logs — read only (System Oversight)
    can :read, AuditLog


    # Read transaction data for shops in their mall
    can :read, EarnTransaction, shop: { mall_id: mall_id }
    can :read, RedeemTransaction, shop: { mall_id: mall_id }
    can :read, Receipt, shop: { mall_id: mall_id }
    can :manage, Offer, shop: { mall_id: mall_id }
    can :create, Offer, shop_id: nil
    can :read, Stamp, shop: { mall_id: mall_id }
    can :read, OfferRedemption, shop: { mall_id: mall_id }
    can :read, StampTransaction, shop: { mall_id: mall_id }
    can :read, UserStampCard
    can :read, Qr, shop: { mall_id: mall_id }
  end

  def shop_admin_abilities(admin)
    shop_id = admin.shop_id

    # Read and update own shop profile
    can [:read, :update], Shop, id: shop_id

    # Offer management (Offer Creation + Offer Management)
    can :manage, Offer, shop_id: shop_id
    can :manage, Stamp, shop_id: shop_id
    can :manage, Receipt, shop_id: shop_id
    can :manage, EarnTransaction, shop_id: shop_id
    can :manage, RedeemTransaction, shop_id: shop_id
    can :manage, Qr, shop_id: shop_id

    # Allow CanCanCan to initialize models during `new` action before shop_id is assigned
    can :create, [Offer, Stamp, Receipt, EarnTransaction, RedeemTransaction, Qr], shop_id: nil

    # Redemption Processing
    can :read, OfferRedemption, shop_id: shop_id
    can :read, StampTransaction, shop_id: shop_id
    can [:read, :create, :update], UserStampCard, stamp: { shop_id: shop_id }
    can :create, UserStampCard, stamp_id: nil

    # Shop admin profile — view and edit own, and view local staff directory
    can :read, ShopAdmin, shop_id: shop_id
    can :update, ShopAdmin, id: admin.id
  end
end
