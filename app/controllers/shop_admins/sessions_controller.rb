module ShopAdmins
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: []
    layout "application"

    def new
      redirect_to shop_admin_root_path if shop_admin_signed_in?
    end

    def create
      admin = ShopAdmin.find_by(email: params[:email]&.downcase&.strip)

      if admin&.authenticate(params[:password])
        session[:shop_admin_id] = admin.id
        session.delete(:mall_admin_id)
        redirect_to shop_admin_root_path, notice: "Signed in successfully."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:shop_admin_id)
      redirect_to root_path, notice: "Signed out successfully."
    end
  end
end
