module Admin::UsersHelper

  def rate_resource
    @rate ||= @user.rates.new
  end

  def project_rate_update(project_id)
    @user_project_to_update = UserProject.where(project_id: project_id[:project_id]).first
    @project_rate = @user_project_to_update.rates.new
  end

  def projects_to_add(user=nil)
    user ||= (@user || @user_project.user)
    Project.where.not id: user.projects.pluck(:id)
  end

  def project_form_params
    { projects: projects_to_add, user_project: user_project, user_project_rates: user_project_rates }
  end
end