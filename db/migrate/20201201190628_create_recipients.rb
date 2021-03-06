class CreateRecipients < ActiveRecord::Migration[6.0]
  def change
    create_table :recipients do |t|
      t.string :name
      t.float :budget
      t.float :spent, default: 0.0

      t.timestamps
    end
  end
end
