class CreateNews < ActiveRecord::Migration[6.1]
  def change
    create_table :news do |t|
      t.boolean :status, null: false
      t.timestamp :news_date, null: false, default: -> {'current_timestamp'}
      t.string :title, limit: 50
      t.text :article
      t.string :category, limit: 50
      t.string :tag, limit: 50

      #t.timestamps
    end
  end
end
