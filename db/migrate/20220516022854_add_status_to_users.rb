class AddStatusToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :check_latest_news, :bool, default: false, null: false, comment: 'true -> チェック済み｜false -> 未チェック'
  end
end
