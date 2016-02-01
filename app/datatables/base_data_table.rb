#
# Simple implementation for jquery Datable (https://datatables.net)
#
class BaseDataTable
  delegate :params, :link_to, :button_to, :number_to_currency, to: :@view

  def initialize(view:, relation: nil)
    @view = view
    @relation = relation
  end

  def as_json(*args)
    {
        draw: params[:draw].to_i,
        recordsTotal: @relation.count,
        recordsFiltered: collection.count,
        aaData: data
    }
  end

  private
  #
  # This function should return an array, containing the names of the db columns corresponding to the table header.
  # Order is important. Make sure you prefix it with table names if necessary.
  #
  def header
    raise NotImplementedError "Datable for #{@relation} must implement header"
  end

  def map_resource(resource)
    raise NotImplementedError "Datable for #{@relation} must define resource map! (called for: #{resource})"
  end

  def data
    collection.map do |resource|
      map_resource resource
    end
  end

  def collection
    @collection ||= fetch_collection
  end

  def fetch_collection_without_page
    @relation.where(search_query).order("#{sort_column} #{sort_direction}")
  end

  def fetch_collection
    fetch_collection_without_page.page(page).per_page per_page
  end

  # pagination
  def page
    params[:start].to_i / per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  # search
  def search_fields
    header
  end

  def search_query
    # This is PG specific at this point.
    keyword = params[:search][:value] rescue nil

    return '1=1' if keyword.blank?
    search_fields.map { |w| "#{w}::text ILIKE '%#{keyword}%'" }.join ' OR '
  end

  # sorting
  def default_sort_column
    header.first
  end

  def sort_column
    header[params[:order]['0'][:column].to_i] rescue default_sort_column
  end

  def sort_direction
    params[:order]['0'][:dir] rescue 'desc'
  end
end
