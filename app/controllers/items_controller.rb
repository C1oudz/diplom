class ItemsController < ApplicationController
    before_action :authenticate_user!
    def index
        @basket_items = Basket.all.where(user_id: current_user.id)
        if params[:search]
          @items = Item.where("title LIKE ? OR id LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
        else
          @items = Item.order(created_at: :desc)
        end
    end
    
    def new

    end
    def create
        @item = Item.new(item_params)
        if (@item.save)
            redirect_to @item
        else
            render 'new'
        end    
    end

    def show
        @item = Item.find(params[:id])
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        if (@item.update(item_params))
            redirect_to @item
        else
            render 'edit'
        end
    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy
        redirect_to items_path
    end

    def authenticate_user!
        redirect_to new_user_session_path, alert:"Войдите в аккаунт чтобы получить доступ ко всем функциям" unless user_signed_in?
    end

    private def item_params
        params.require(:item).permit(:id, :title, :address, :buyprice, :sellprice, :ostatok, :picture)
    end
end
