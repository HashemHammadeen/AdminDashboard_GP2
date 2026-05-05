class RenameQrsToQrCode < ActiveRecord::Migration[8.1]
  def change
    rename_table :qrs, :qr_code
  end
end
