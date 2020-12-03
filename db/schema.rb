# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_01_191037) do

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.string "link"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "recipient_items", force: :cascade do |t|
    t.integer "recipient_id", null: false
    t.integer "item_id", null: false
    t.boolean "bought", default: false
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_recipient_items_on_item_id"
    t.index ["recipient_id"], name: "index_recipient_items_on_recipient_id"
  end

  create_table "recipients", force: :cascade do |t|
    t.string "name"
    t.float "budget"
    t.float "spent", default: 0.0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "recipient_items", "items"
  add_foreign_key "recipient_items", "recipients"
end
