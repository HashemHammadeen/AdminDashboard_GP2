module MallAdmins
  class SessionsController < ApplicationController
    skip_before_action :verify_authenticity_token, only: []
    layout "application"

    def new
      redirect_to mall_admin_root_path if mall_admin_signed_in?
    end

    def create
      admin = MallAdmin.find_by(email: params[:email]&.downcase&.strip)

      if admin&.authenticate(params[:password])
        session[:mall_admin_id] = admin.id
        session.delete(:shop_admin_id)
        redirect_to mall_admin_root_path, notice: "Signed in successfully."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      session.delete(:mall_admin_id)
      redirect_to root_path, notice: "Signed out successfully."
    end
  end
end
