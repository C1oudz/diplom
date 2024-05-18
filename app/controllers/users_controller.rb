class UsersController < ApplicationController
    def index
        @users = User.all.order(created_at: :desc)
    end

    def new
        @user = User.new
    end

    def create
        if current_user.admin?
        @user = User.new(user_params)
            if @user.save
                redirect_to allusers_path, notice: 'Информация была успешно изменена.'
            else
                render 'new', notice: 'Произошла ошибка'
            end   
        else
            flash[:alert] = "Только администратор может создавать новых пользователей."
            redirect_to home_path
        end
    end

    def change_roles
        if current_user.admin?
          @user = User.find(params[:id]) # Найти пользователя по его id
        else
            redirect_to users_path, alert: 'Вы не имеете доступа'
        end
    end

    def update
        if current_user.admin? 
          @user = User.find(params[:id])
          if @user.update(user_params)
             redirect_to allusers_path, notice: 'Информация была успешно изменена.'
          else
             render :change_roles
          end
        end
    end

    def user_params
        params.require(:user).permit(:firstnamename, :secondname, :surname, :email, :password, :password_confirmation, :role)
    end
end