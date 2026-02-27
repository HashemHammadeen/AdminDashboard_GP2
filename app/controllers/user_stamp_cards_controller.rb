class UserStampCardsController < ApplicationController
  before_action :authenticate_any_admin!
  authorize_resource
  layout "dashboard"

  def index
    if current_shop
      stamp_ids = current_shop.stamps.pluck(:id)
      @user_stamp_cards = UserStampCard.where(stamp_id: stamp_ids)
    elsif current_mall_admin
      stamp_ids = Stamp.joins(:shop).where(shops: { mall_id: current_mall_admin.mall_id }).pluck(:id)
      @user_stamp_cards = UserStampCard.where(stamp_id: stamp_ids)
    else
      @user_stamp_cards = UserStampCard.none
    end
    
    @user_stamp_cards = @user_stamp_cards.includes(:user, :stamp).order(updated_at: :desc)
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @user_stamp_card.update(user_stamp_card_params)
        format.html { redirect_to @user_stamp_card, notice: "User stamp card updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_stamp_card_params
    params.expect(user_stamp_card: [:stamps_collected])
  end
end
