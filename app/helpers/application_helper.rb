module ApplicationHelper
  String.class_eval do
    def to_cc
      str = self.dup || ''
      str.gsub!(/[^a-zA-Z ]/,'')
      str.squish.split(' ').map(&:capitalize).join
    end
  end

  def xls_index_for(row, col)
    c = 'A'
    col.to_i.times { c.succ! }

    "#{c}#{row.to_i + 1}"
  end

  def resource_title
    collection_title.singularize
  end

  def collection_title
    controller_name.capitalize
  end

  def alert_class
    alert ? 'bg-danger' : 'hide'
  end

  def notice_class
    notice ? 'bg-success' : 'hide'
  end

  def app_title
    Figaro.env.app_title || 'App Name'
  end

  def remove_options(options = {})
    options.merge(
        method: :patch,
        data: { confirm: 'Are you sure?' },
        role: 'button',
        class: 'btn btn-default',
        style: 'float: right;'
    )
  end
end
