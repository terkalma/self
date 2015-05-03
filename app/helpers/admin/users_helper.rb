module Admin::UsersHelper
  def resource_name
    @user.name rescue 'John Doe'
  end
end