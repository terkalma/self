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
      @users_to_add = User.where.not(id: @project.users.pluck(:id))

      add_breadcrumb "Editing Project: #{@project.name}", edit_admin_project_path(@project)
    end

    def add_user
      begin
        project = Project.find_by_slug add_user_params[:slug]
        project.user_ids += [add_user_params[:users]]
        flash[:notice] = 'Person successfully added'
      rescue
        flash[:alert] = 'Unable to add the person to the project'
      end

      redirect_to action: :edit, id: add_user_params[:slug]
    end

    def remove_user
      begin
        project = Project.find_by_slug params[:slug]
        UserProject.where(project_id: project.id, user_id: params[:user_id]).delete_all
        flash[:notice] = 'Person successfully removed'
      rescue
        flash[:alert] = 'Unable to remove the person from the project'
      end

      redirect_to action: :edit, id: params[:slug]
    end

    private
    def add_user_params
      params.require(:project).permit(:slug, :users)
    end

    def create_project_params
      params.require(:project).permit(:name)
    end
  end
end