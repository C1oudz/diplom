class BasketsController < ApplicationController

    def index
        @basket_items = current_user.basket_items
        @basket_empty = @basket_items.blank?
    end

    def add_to_basket
        item_id = params[:item_id]
        quantity = params[:quantity].to_i
        user_id = params[:user_id]
        item = Item.find(item_id)
        if quantity > item.ostatok
          redirect_to items_path, alert: 'Недостаточно товара на складе'
        else
          Basket.create(item_id: item_id, quantity: quantity, user_id: user_id)
          redirect_to items_path, notice: 'Товар добавлен в заказ'
        end
    end

end
