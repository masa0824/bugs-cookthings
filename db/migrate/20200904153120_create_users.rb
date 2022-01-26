class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :first_name, limit: 255
      t.string :last_name, limit: 255
      t.string :email, :null => false, limit: 255
      t.string :password_digest, :null => false

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end
