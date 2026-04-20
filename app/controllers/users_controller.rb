class UsersController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @users = @users.includes(:tier).order(created_at: :desc)
    
    if params[:search].present?
      search_term = "%#{params[:search]}%"
      @users = @users.where("firstname ILIKE ? OR lastname ILIKE ? OR email ILIKE ? OR phone ILIKE ?", search_term, search_term, search_term, search_term)
    end
    
    if params[:tier_id].present?
      @users = @users.where(tier_id: params[:tier_id])
    end
  end

  def show; end
  def edit; end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated.", status: :see_other }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy!
    redirect_to users_path, notice: "User was successfully deleted.", status: :see_other
  end

  private

  def user_params
    params.expect(user: [:firstname, :lastname, :email, :phone, :gender, :tier_id, :profile_image_url])
  end
end
