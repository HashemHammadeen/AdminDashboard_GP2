class UserStampCardsController < ApplicationController
  before_action :authenticate_any_admin!
  authorize_resource
  layout "dashboard"

  def index
    if current_shop
      stamp_ids = current_shop.stamps.pluck(:stamp_id)
      @user_stamp_cards = UserStampCard.where(stamp_id: stamp_ids)
    elsif current_mall_admin
      stamp_ids = Stamp.joins(:shop).where(shop: { mall_id: current_mall_admin.mall_id }).pluck(:stamp_id)
      @user_stamp_cards = UserStampCard.where(stamp_id: stamp_ids)
    else
      @user_stamp_cards = UserStampCard.none
    end
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @user_stamp_cards = @user_stamp_cards.left_outer_joins(:user, :stamp).where(
        "user.first_name ILIKE :search OR user.last_name ILIKE :search OR user.email ILIKE :search OR stamp.name ILIKE :search",
        search: search_term
      )
    end

    @user_stamp_cards = @user_stamp_cards.includes(:user, :stamp).order(created_at: :desc)
  end

  def show; end

  def new
    @user_stamp_card = UserStampCard.new
    @stamps = current_shop ? current_shop.stamps.where(is_active: true) : Stamp.none
    @users = User.all
  end

  def create
    permitted = user_stamp_card_params
    user = User.find_by(user_id: permitted[:user_id])
    stamp = Stamp.find_by(stamp_id: permitted[:stamp_id])
    stamps_to_add = permitted[:stamps_collected].to_i

    if user && stamp && current_shop && stamp.shop_id == current_shop.id
      @user_stamp_card = UserStampCard.find_or_initialize_by(user: user, stamp: stamp)

      @user_stamp_card.stamps_counter ||= 0
      @user_stamp_card.stamps_counter += stamps_to_add
      @user_stamp_card.is_completed = true if @user_stamp_card.stamps_counter >= stamp.stamps_required
      @user_stamp_card.last_transaction = Time.current

      if @user_stamp_card.save
        StampTransaction.create!(
          user: user,
          shop: current_shop,
          stamp_program_id: stamp.id,
          stamps_count: stamps_to_add,
          type: "collect"
        )
        redirect_to user_stamp_cards_path, notice: "Successfully assigned #{stamps_to_add} stamps to #{user.first_name}."
      else
        @stamps = current_shop.stamps.where(is_active: true)
        @users = User.all
        render :new, status: :unprocessable_entity
      end
    else
      @user_stamp_card = UserStampCard.new
      @user_stamp_card.errors.add(:base, "Invalid user or stamp program selected")
      @stamps = current_shop ? current_shop.stamps.where(is_active: true) : Stamp.none
      @users = User.all
      render :new, status: :unprocessable_entity
    end
  end

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
    params.expect(user_stamp_card: [:user_id, :stamp_id, :stamps_collected])
  end
end
