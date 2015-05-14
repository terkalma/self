class UserReportDataTable < BaseDataTable
  delegate :edit_admin_user_path, to: :@view

  def initialize(view:, relation: nil)
    if relation
      super view: view, relation: relation.select(select_fields)
    else
      super view: view, relation: Event.joins(:user).group('users.id').select(select_fields)
    end
  end

  def as_json(*args)
    {
      draw: params[:draw].to_i,
      recordsTotal: User.joins(:events).pluck('users.id').uniq.count,
      recordsFiltered: data.count,
      aaData: data
    }
  end

  private
  def select_fields
    [
      'users.id as user_id',
      "(users.first_name || ' ' || users.last_name) as user_name",
      'sum(events.amount) as total_amount',
      'sum(events.hours) + sum(events.minutes) / 60.0 as total_hours'
    ]
  end

  def search_fields
    %w[users.first_name users.last_name]
  end

  def header
    %w[user_name total_amount total_hours]
  end

  def collection
    ActiveRecord::Base.connection.execute(fetch_collection.to_sql).to_a
  end

  def map_resource(resource)
    [
      link_to(resource['user_name'], edit_admin_user_path(resource['user_id'])),
      number_to_currency(resource['total_amount']),
      "#{resource['total_hours'].to_f.round 2} hours"
    ]
  end
end
