class MallAdminsController < ApplicationController
  before_action :set_mall_admin, only: %i[ show edit update destroy ]

  # GET /mall_admins or /mall_admins.json
  def index
    @mall_admins = MallAdmin.all
  end

  # GET /mall_admins/1 or /mall_admins/1.json
  def show
  end

  # GET /mall_admins/new
  def new
    @mall_admin = MallAdmin.new
  end

  # GET /mall_admins/1/edit
  def edit
  end

  # POST /mall_admins or /mall_admins.json
  def create
    @mall_admin = MallAdmin.new(mall_admin_params)

    respond_to do |format|
      if @mall_admin.save
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully created." }
        format.json { render :show, status: :created, location: @mall_admin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mall_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mall_admins/1 or /mall_admins/1.json
  def update
    respond_to do |format|
      if @mall_admin.update(mall_admin_params)
        format.html { redirect_to @mall_admin, notice: "Mall admin was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @mall_admin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mall_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mall_admins/1 or /mall_admins/1.json
  def destroy
    @mall_admin.destroy!

    respond_to do |format|
      format.html { redirect_to mall_admins_path, notice: "Mall admin was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mall_admin
      @mall_admin = MallAdmin.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def mall_admin_params
      params.expect(mall_admin: [ :mall_id, :name, :email, :phone, :password_hash ])
    end
end
