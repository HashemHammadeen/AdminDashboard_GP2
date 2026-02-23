class TiersController < ApplicationController
  before_action :set_tier, only: %i[ show edit update destroy ]

  # GET /tiers or /tiers.json
  def index
    @tiers = Tier.all
  end

  # GET /tiers/1 or /tiers/1.json
  def show
  end

  # GET /tiers/new
  def new
    @tier = Tier.new
  end

  # GET /tiers/1/edit
  def edit
  end

  # POST /tiers or /tiers.json
  def create
    @tier = Tier.new(tier_params)

    respond_to do |format|
      if @tier.save
        format.html { redirect_to @tier, notice: "Tier was successfully created." }
        format.json { render :show, status: :created, location: @tier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tiers/1 or /tiers/1.json
  def update
    respond_to do |format|
      if @tier.update(tier_params)
        format.html { redirect_to @tier, notice: "Tier was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @tier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tiers/1 or /tiers/1.json
  def destroy
    @tier.destroy!

    respond_to do |format|
      format.html { redirect_to tiers_path, notice: "Tier was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tier
      @tier = Tier.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def tier_params
      params.expect(tier: [ :tier_name, :points_required, :benefits, :icon_url, :color_hex ])
    end
end
