class ShopAdminsController < ApplicationController
  before_action :set_shop_admin, only: %i[ show edit update destroy ]

  # GET /shop_admins or /shop_admins.json
  def index
    @shop_admins = ShopAdmin.all
  end

  # GET /shop_admins/1 or /shop_admins/1.json
  def show
  end

  # GET /shop_admins/new
  def new
    @shop_admin = ShopAdmin.new
  end

  # GET /shop_admins/1/edit
  def edit
  end

  # POST /shop_admins or /shop_admins.json
  def create
    @shop_admin = ShopAdmin.new(shop_admin_params)

    respond_to do |format|
      if @shop_admin.save
        format.html { redirect_to @shop_admin, notice: "Shop admin was successfully created." }
        format.json { render :show, status: :created, location: @shop_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shop_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shop_admins/1 or /shop_admins/1.json
  def update
    respond_to do |format|
      if @shop_admin.update(shop_admin_params)
        format.html { redirect_to @shop_admin, notice: "Shop admin was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @shop_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shop_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shop_admins/1 or /shop_admins/1.json
  def destroy
    @shop_admin.destroy!

    respond_to do |format|
      format.html { redirect_to shop_admins_path, notice: "Shop admin was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shop_admin
      @shop_admin = ShopAdmin.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def shop_admin_params
      params.expect(shop_admin: [ :shop_id, :name, :email, :phone, :password_hash, :is_active ])
    end
end
