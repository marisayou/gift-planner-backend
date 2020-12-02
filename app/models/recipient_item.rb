class RecipientItem < ApplicationRecord
  belongs_to :recipient
  belongs_to :item
end
