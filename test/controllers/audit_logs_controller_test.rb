require "test_helper"
require_relative "malls_controller_test"

class AuditLogsControllerTest < ActionDispatch::IntegrationTest
  include TestSetupHelper

  def setup
    @mall = create_mall
    @mall_admin = create_mall_admin(@mall)
    @audit_log = AuditLog.create!(
      action_type: "mall_created",
      mall_admin_id: @mall_admin.id,
      metadata: { "test" => "data" }
    )
  end

  test "unauthenticated redirects to login" do
    get audit_logs_url
    assert_redirected_to root_path
  end

  test "mall admin can list audit logs" do
    login_as_mall_admin(@mall_admin)
    get audit_logs_url
    assert_response :success
  end

  test "mall admin can view an audit log" do
    login_as_mall_admin(@mall_admin)
    get audit_log_url(@audit_log)
    assert_response :success
  end
end
