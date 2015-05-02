module Admin
  class UsersController < BaseController

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Users', :admin_users_path

    def index
      @users = User.all
    end

    def edit
      @user = User.find params[:id]
      add_breadcrumb "Editing User: #{@user.name}", edit_admin_user_path(@user.id)
    end
  end
end