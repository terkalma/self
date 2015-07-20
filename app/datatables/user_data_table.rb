class UserDataTable < BaseDataTable
  delegate :edit_admin_user_path, to: :@view

  def initialize(view:, relation: nil)
    super view: view, relation:  relation.select(select_fields) || User.select(select_fields)
  end

  def as_json(*args)
    {
        draw: params[:draw].to_i,
        recordsTotal: User.count,
        recordsFiltered: data.count,
        aaData: data
    }
  end

  private
  def map_resource(user)
    [
        link_to(user['user_name'], edit_admin_user_path(user['id'])),
        user['email'],
        user['created_at'].to_s
    ]
  end

  def collection
    ActiveRecord::Base.connection.execute(fetch_collection.to_sql).to_a
  end

  def search_fields
    %w[users.first_name users.last_name email]
  end

  def header
    %w[user_name email created_at]
  end

  def default_sort_column
    'user_name'
  end

  def select_fields
    [
        'id',
        "(users.first_name || ' ' || users.last_name) as user_name",
        'email',
        'created_at'
    ]
  end
end
