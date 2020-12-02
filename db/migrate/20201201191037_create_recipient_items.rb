class CreateRecipientItems < ActiveRecord::Migration[6.0]
  def change
    create_table :recipient_items do |t|
      t.references :recipient, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.boolean :bought, default: false
      t.integer :price, default: nil

      t.timestamps
    end
  end
end
