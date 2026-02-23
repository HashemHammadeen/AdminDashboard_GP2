class StampsController < ApplicationController
  before_action :set_stamp, only: %i[ show edit update destroy ]

  # GET /stamps or /stamps.json
  def index
    @stamps = Stamp.all
  end

  # GET /stamps/1 or /stamps/1.json
  def show
  end

  # GET /stamps/new
  def new
    @stamp = Stamp.new
  end

  # GET /stamps/1/edit
  def edit
  end

  # POST /stamps or /stamps.json
  def create
    @stamp = Stamp.new(stamp_params)

    respond_to do |format|
      if @stamp.save
        format.html { redirect_to @stamp, notice: "Stamp was successfully created." }
        format.json { render :show, status: :created, location: @stamp }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stamps/1 or /stamps/1.json
  def update
    respond_to do |format|
      if @stamp.update(stamp_params)
        format.html { redirect_to @stamp, notice: "Stamp was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @stamp }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @stamp.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stamps/1 or /stamps/1.json
  def destroy
    @stamp.destroy!

    respond_to do |format|
      format.html { redirect_to stamps_path, notice: "Stamp was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stamp
      @stamp = Stamp.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def stamp_params
      params.expect(stamp: [ :shop_id, :name, :description, :image_url, :stamp_icon_url, :stamps_required, :reward_type, :active, :start_date, :end_date ])
    end
end
