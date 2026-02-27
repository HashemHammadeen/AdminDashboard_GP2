class AuditLogsController < ApplicationController
  before_action :authenticate_any_admin!
  load_and_authorize_resource
  layout "dashboard"

  def index
    @audit_logs = @audit_logs.order(created_at: :desc)
  end

  def show; end
end
