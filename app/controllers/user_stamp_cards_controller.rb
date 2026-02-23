class UserStampCardsController < ApplicationController
  before_action :set_user_stamp_card, only: %i[ show edit update destroy ]

  # GET /user_stamp_cards or /user_stamp_cards.json
  def index
    @user_stamp_cards = UserStampCard.all
  end

  # GET /user_stamp_cards/1 or /user_stamp_cards/1.json
  def show
  end

  # GET /user_stamp_cards/new
  def new
    @user_stamp_card = UserStampCard.new
  end

  # GET /user_stamp_cards/1/edit
  def edit
  end

  # POST /user_stamp_cards or /user_stamp_cards.json
  def create
    @user_stamp_card = UserStampCard.new(user_stamp_card_params)

    respond_to do |format|
      if @user_stamp_card.save
        format.html { redirect_to @user_stamp_card, notice: "User stamp card was successfully created." }
        format.json { render :show, status: :created, location: @user_stamp_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_stamp_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_stamp_cards/1 or /user_stamp_cards/1.json
  def update
    respond_to do |format|
      if @user_stamp_card.update(user_stamp_card_params)
        format.html { redirect_to @user_stamp_card, notice: "User stamp card was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @user_stamp_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_stamp_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_stamp_cards/1 or /user_stamp_cards/1.json
  def destroy
    @user_stamp_card.destroy!

    respond_to do |format|
      format.html { redirect_to user_stamp_cards_path, notice: "User stamp card was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_stamp_card
      @user_stamp_card = UserStampCard.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def user_stamp_card_params
      params.expect(user_stamp_card: [ :user_id, :stamp_id, :stamps_counter, :is_completed, :last_transaction ])
    end
end
