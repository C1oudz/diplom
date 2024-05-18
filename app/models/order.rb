class Order < ApplicationRecord
    belongs_to :user
    has_many :order_items, dependent: :destroy
    has_many :items, through: :order_items
    validates :client_name, presence: true
    enum status: { передан_в_работу: 0, на_сборке: 1, отгружен: 2 }
    after_initialize :set_default_status, :if => :new_record? 
    def set_default_status
      self.status ||= :передан_в_работу
    end
end