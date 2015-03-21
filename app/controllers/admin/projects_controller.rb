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
    begin
      project = Project.find_by_slug permitted_params[:slug]
      project.user_ids += [permitted_params[:user_ids]]
      flash[:notice] = 'Person successfully added'
    rescue
      flash[:alert] = 'Unable to add the person to the project'
    end

    redirect_to action: :edit, id: permitted_params[:slug]
  end

  private
  def permitted_params
    params.require(:project).permit(:slug, :user_ids)
  end
end
