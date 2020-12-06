class CreateSearchItems < ActiveRecord::Migration[6.0]
  def change
    create_table :search_items do |t|
      t.string :name
      t.float :price
      t.string :link
      t.string :image_url

      t.timestamps
    end
  end
end
