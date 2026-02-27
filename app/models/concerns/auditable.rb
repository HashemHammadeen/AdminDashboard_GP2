module Auditable
  extend ActiveSupport::Concern

  included do
    after_commit :log_create_action, on: :create
    after_commit :log_update_action, on: :update
    after_commit :log_destroy_action, on: :destroy
  end

  private

  def log_create_action
    create_audit_log("create")
  end

  def log_update_action
    # Don't log if the only changes were Devise tracking/timestamp columns
    return if saved_changes.keys.all? { |k| ignored_audit_columns.include?(k) }
    create_audit_log("update")
  end

  def log_destroy_action
    create_audit_log("destroy")
  end

  def create_audit_log(action)
    return unless Current.admin

    # Safely extract relations if they exist on the model
    opts = {
      action_type: "#{self.class.name.underscore}_#{action}",
      admin_id: Current.admin.id,
      admin_type: Current.admin.class.name.underscore,
      metadata: {
        model_name: self.class.name,
        record_id: id,
        changes: action == "destroy" ? attributes : filtered_changes
      }
    }

    # Extract associated shop/user if model has them directly
    opts[:shop_id] = shop_id if respond_to?(:shop_id)
    opts[:user_id] = user_id if respond_to?(:user_id)

    # Automatically extract points change if points are involved
    if self.class.name == "UserPointsBalance" && saved_change_to_total_points?
      old_val, new_val = saved_changes["total_points"]
      opts[:points] = new_val.to_i - old_val.to_i
    elsif respond_to?(:points_earned)
      opts[:points] = action == "destroy" ? -points_earned.to_i : points_earned.to_i
    elsif respond_to?(:points_used)
      opts[:points] = action == "destroy" ? points_used.to_i : -points_used.to_i
    end

    AuditLog.create!(opts)
  rescue => e
    Rails.logger.error "AuditLog Creation Failed: #{e.message}"
  end

  def filtered_changes
    saved_changes.except(*ignored_audit_columns)
  end

  def ignored_audit_columns
    %w[
      updated_at created_at
      encrypted_password reset_password_token reset_password_sent_at
      remember_created_at sign_in_count current_sign_in_at last_sign_in_at
      current_sign_in_ip last_sign_in_ip
    ]
  end
end
