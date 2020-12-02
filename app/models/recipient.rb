class Recipient < ApplicationRecord
    has_many :recipient_items, dependent: :destroy
    has_many :items, through: :recipient_items
end
