class UserStampCardsController < ApplicationController
  before_action :authenticate_shop_admin!
  before_action :set_user_stamp_card, only: %i[show edit update]
  layout "dashboard"

  def index
    stamp_ids = current_shop_admin.shop.stamps.pluck(:id)
    @user_stamp_cards = UserStampCard.where(stamp_id: stamp_ids).includes(:stamp)
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user_stamp_card.update(user_stamp_card_params)
        format.html { redirect_to user_stamp_cards_path, notice: "User stamp card was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_stamp_card.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user_stamp_card
    stamp_ids = current_shop_admin.shop.stamps.pluck(:id)
    @user_stamp_card = UserStampCard.where(stamp_id: stamp_ids).find_by!(user_id: params[:user_id], stamp_id: params[:stamp_id])
  end

  def user_stamp_card_params
    params.expect(user_stamp_card: [:stamps_counter, :is_completed])
  end
end
