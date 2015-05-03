module Admin
  class UsersController < BaseController

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Users', :admin_users_path

    def index
      @users = User.all
    end

    def edit
      @user = User.find params[:id]

      unless @user.payable?
        flash.now[:alert] = "#{@user.name} does not have a base rate. Please add one."
      end

      add_breadcrumb "Editing User: #{@user.name}", edit_admin_user_path(@user.id)
    end

    def add_rate
      @rate = Rate.new add_rate_params
      @success = @rate.save

      respond_to do |format|
        format.js
        format.html do
          if @success
            flash[:notice] = 'Rate successfully added'
          else
            flash[:alert] = 'Unable to add rate to the person'
          end
          redirect_to edit_admin_user_path(@rate.user)
        end
      end
    end

    private
    def add_rate_params
      params.require(:rate).permit :payable_id, :payable_type, :available_from,
                                   :available_until, :hourly_rate, :hourly_rate_ot
    end
  end
end