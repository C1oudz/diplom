class AddQuantityToBasket < ActiveRecord::Migration[6.1]
  def change
    add_column :baskets, :quantity, :integer
  end
end
