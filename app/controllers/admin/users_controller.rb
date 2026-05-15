module Admin
  class UsersController < BaseController
    def index
      @users = User.order(:nickname)
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if user_params[:password].present?
        @user.password = user_params[:password]
        @user.password_confirmation = user_params[:password]
      end
      @user.nickname = user_params[:nickname] if user_params[:nickname].present?

      if @user.save
        redirect_to admin_users_path, notice: "#{@user.nickname} さんの情報を更新しました。"
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:nickname, :password)
    end
  end
end
