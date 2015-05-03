module Admin::UsersHelper

  def rate_resource
    @rate ||= @user.rates.new
  end
end