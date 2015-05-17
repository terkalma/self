module Admin::ProjectsHelper
  def users_to_add(project=nil)
    project ||= (@project || @user_project.project)
    User.where.not id: project.users.pluck(:id)
  end

  def user_project
    @user_project ||= (@project || @user).user_projects.new rescue UserProject.new
  end

  def user_project_rates
    @user_project_rates ||= if user_project.rates.empty?
      user_project.rates.new
    else
      user_project.rates
    end
  end

  #
  # @param user_project [UserProject] getting rates
  #
  def project_details(user_project)
    return @rates[user_project.id] if defined?(@rates) && @rates[user_project.id]

    @rates ||= {}

    ret = Hashie::Mash.new({}, '-')

    if user_project.payable?
      ret.hourly_rate = user_project.current_rate.hourly_rate
      ret.hourly_rate_ot = user_project.current_rate.hourly_rate_ot
    end

    @rates[user_project.id] = ret
  end

  def user_form_params
    { users: users_to_add, user_project: user_project, user_project_rates: user_project_rates }
  end
end
