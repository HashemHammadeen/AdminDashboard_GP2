class AuditLogsController < ApplicationController
  before_action :authenticate_mall_admin!
  layout "dashboard"

  def index
    @audit_logs = AuditLog.order(created_at: :desc).limit(100)
  end

  def show
    @audit_log = AuditLog.find(params[:id])
  end
end
