class CreateOfferRedemptions < ActiveRecord::Migration[8.1]
  def change
    # 1. Added id: :uuid
    create_table :offer_redemptions, id: :uuid do |t|
      # 2. Added type: :uuid to all references
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :offer, type: :uuid, null: false, foreign_key: true
      t.references :shop, type: :uuid, null: false, foreign_key: true

      # 3. Changed null: false to null: true for optional receipts
      t.references :receipt, type: :uuid, null: true, foreign_key: true

      t.timestamps
    end
  end
end