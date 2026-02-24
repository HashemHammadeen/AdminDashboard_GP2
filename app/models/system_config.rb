class SystemConfig < ApplicationRecord
  self.table_name = "system_configs"
  belongs_to :updated_by_admin, class_name: "MallAdmin", foreign_key: "updated_by_admin_id", optional: true
end