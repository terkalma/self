class ReportSheet
  #
  # @param to[Date]
  # @param from[Date]
  # @param search_query[String]
  #
  def initialize(from:, to:, search_query: nil)
    @from = from
    @to = to
    @search_query = search_query
  end

  def table_from
    @table_from ||= Event.joins(:user).between(@from, @to).where(search).minimum :worked_at
  end

  def table_to
    @table_to ||= Event.joins(:user).between(@from, @to).where(search).maximum :worked_at
  end

  def data
    return @data if @data

    @data = Hash.new

    collection.each do |resource|
      key = resource['user_email'].split(/@/).first

      if @data[key]
        @data[key] << { resource['worked_at'] => resource['total_amount'].to_f.round(2) }
      else
        @data[key] = { resource['worked_at'] => resource['total_amount'].to_f.round(2) }
      end
    end

    @data
  end

  private
  def select_fields
    [
        'users.email as user_email',
        'sum(events.amount) as total_amount',
        'events.worked_at as worked_at',
    ]
  end

  def search
    if @search_query.present?
      "users.first_name::text ILIKE '%#{@search_query}%' OR users.last_name::text ILIKE '%#{@search_query}%'"
    else
      '1=1'
    end
  end

  def query
    @query ||= Event.between(@from, @to)
                        .joins(:user)
                        .group('users.id, events.worked_at')
                        .where(search)
                        .select(select_fields).to_sql
  end

  def collection
    @collection ||= ActiveRecord::Base.connection.execute(query).to_a
  end
end