class Basket < ApplicationRecord
    belongs_to :item
    belongs_to :user
    validate :quantity_not_exceed_ostatok
  
    private
  
    def quantity_not_exceed_ostatok
      if quantity > item.ostatok
        errors.add(:quantity, "Не может превышать остаток на складе")
      end
    end
  end