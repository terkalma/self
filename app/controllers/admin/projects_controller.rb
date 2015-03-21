class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create

  end

  def edit
    @project = Project.find_by_slug params[:id]
    @users_to_add = User.where.not(id: @project.users.pluck(:id))
  end

  def update

  end

  def add_user
    begin
      project = Project.find_by_slug add_user_params[:slug]
      project.user_ids += [add_user_params[:user_ids]]
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
    params.require(:project).permit(:slug, :user_ids)
  end
end
