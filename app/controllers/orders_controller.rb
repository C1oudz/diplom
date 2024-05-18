class OrdersController < ApplicationController

    def index
        @orders = Order.includes(:user).all
        @orders_items=OrderItem.all
    end

    def new
        @basket_items = Basket.all.where(user_id: current_user.id)
        @order = Order.new
        @total_cost = 0
        @basket_items.each do |item|
          @total_cost += item.item.sellprice * item.quantity
        end
      end

      def create
        if order_params[:client_name].present?
            @order = current_user.orders.build(order_params)
            @basket_items = current_user.baskets.all
            if @basket_items.present?
                @basket_items.sum { |item| item.item.sellprice * item.quantity }
            else
                0
            end
            @order.total_cost = calculate_total_cost
            if @order.save
            if @basket_items.present?
                @basket_items.each do |item|
                order_item = @order.order_items.build(item_id: item.item_id, quantity: item.quantity)
                order_item.save
                item.item.update(ostatok: item.item.ostatok - item.quantity)
                end
        
                @basket_items.destroy_all
                redirect_to home_path, notice: "Заказ успешно создан."
            else
                redirect_to home_path, notice: "Заказ успешно создан, но корзина пуста."
            end
            else
            render :new
            end
        else
            redirect_to new_order_path, alert: 'Ошибка, введите клиента'
        end
      end

      def clear_basket
        @basket_items = current_user.baskets.all
        if @basket_items.destroy_all
          redirect_to home_path, notice: 'Корзина очищена'
        else
          redirect_to new_order_path, alert: 'Ошибка, не удалось очистить корзину'
        end
      end
      
      private
      
      def order_params
        params.require(:order).permit(:client_name)
      end
      
      def calculate_total_cost
        if @basket_items.present?
          @basket_items.sum { |item| item.item.sellprice * item.quantity }
        else
          0
        end
      end
end
