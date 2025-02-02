class Item < ApplicationRecord
    has_many :order_items
    has_many :orders, through: :order_items
    has_one_attached :picture
end
