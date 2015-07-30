class UserDataTable < BaseDataTable
  delegate :edit_admin_user_path, to: :@view

  def initialize(view:, relation: nil)
    super view: view, relation:  relation || User
  end

  private
  def map_resource(user)
    [
        link_to(user.name, edit_admin_user_path(user)),
        user.email,
        user.created_at.to_s
    ]
  end

  def search_fields
    %w[users.first_name users.last_name email]
  end

  def header
    %w[first_name email created_at]
  end

  def default_sort_column
    'first_name'
  end
end
