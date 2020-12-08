class Item < ApplicationRecord
    has_many :recipient_items, dependent: :destroy
    has_many :recipients, through: :recipient_items
end
