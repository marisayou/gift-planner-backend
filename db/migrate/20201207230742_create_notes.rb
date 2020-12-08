class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.references :recipient, null: false, foreign_key: true
      t.string :message

      t.timestamps
    end
  end
end
