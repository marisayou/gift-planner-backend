class Item < ApplicationRecord
    has_many :recipient_items
    has_many :recipients, through: :recipient_items
end
