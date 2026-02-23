class CreateUserStampCards < ActiveRecord::Migration[8.1]
  def change
    create_table :user_stamp_cards, id: false do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :stamp, type: :uuid, null: false, foreign_key: true
      t.integer :stamps_counter, default: 0
      t.boolean :is_completed, default: false
      t.datetime :last_transaction
      t.timestamps

    end

    add_index :user_stamp_cards, [:user_id, :stamp_id], unique: true
  end

end
