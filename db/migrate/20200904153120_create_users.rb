class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, :null => false, limit: 255
      t.string :password_digest, :null => false

      t.string :activation_digest
      t.boolean :activated, :default => false
      t.datetime :activated_at

      t.string :reset_digest
      t.datetime :reset_sent_at

      t.integer :acount_plan, limit: 1, :default => 1, :null => false, comment: "1 -> 無料プラン｜2 -> 有料プラン"
      t.boolean :acount_lock, :default => false, :null => false, comment: "1 -> 無料プラン｜2 -> 有料プラン"

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end