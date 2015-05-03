module Admin
  class ProjectsController < BaseController

    add_breadcrumb 'Admin', :admin_dashboard_path
    add_breadcrumb 'Projects', :admin_projects_path

    def index
      @projects = Project.all
    end

    def create
      begin
        project = Project.create(create_project_params)
        flash[:notice] = 'Project created successfully'

        redirect_to action: :edit, id: project.slug
      rescue
        flash[:alert] = 'Unable to create project'

        redirect_to action: index
      end
    end

    def edit
      @project = Project.find_by_slug params[:id]
      add_breadcrumb "Editing Project: #{@project.name}", edit_admin_project_path(@project)
    end

    def add_user
      @user_project = UserProject.new add_user_params
      @success = @user_project.save

      respond_to do |format|
        format.js
        format.html do
          if @success
            flash[:notice] = 'Person successfully added'
          else
            flash[:alert] = 'Unable to add person to the project'
          end
          redirect_to edit_admin_project_path(@user_project.project)
        end
      end
    end

    def remove_user
      begin
        project = Project.find_by_slug params[:slug]
        UserProject.where(project_id: project.id, user_id: params[:user_id]).destroy_all
        flash[:notice] = 'Person successfully removed'
      rescue
        flash[:alert] = 'Unable to remove the person from the project'
      end

      redirect_to action: :edit, id: params[:slug]
    end

    private
    def add_user_params
      rates_attributes = [ :hourly_rate, :hourly_rate_ot, :available_from, :available_until ]
      params.require(:user_project).permit(:user_id, :project_id, rates_attributes: rates_attributes)
    end

    def create_project_params
      params.require(:project).permit(:name)
    end
  end
end