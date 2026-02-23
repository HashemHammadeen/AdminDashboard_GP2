class CreateUserPointsBalances < ActiveRecord::Migration[8.1]
  def change
    create_table :user_points_balances, id: false do |t|
      t.references :user, type: :uuid, null: false, primary_key: true, foreign_key: true
      t.integer :total_points, default: 0
      t.integer :lifetime_points, default: 0
      t.timestamps
    end
  end
end
