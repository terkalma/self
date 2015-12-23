module ApplicationHelper
  String.class_eval do
    def to_cc
      str = self.dup || ''
      str.gsub!(/[^a-zA-Z ]/,'')
      str.squish.split(' ').map(&:capitalize).join
    end
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
    {
        method: :patch,
        data: { confirm: 'Are you sure?' },
        role: 'button',
        class: 'btn btn-default',
        style: 'float: right;'
    }.merge options
  end

  def validation_class(object, column)
    (object && object.errors[column].present?) ? 'invalid' : ''
  end

  def validation_message(object, column)
    label = <<-HTML
      <label class="validation error">
        #{object && object.errors[column].join('. ')}
      </label>
    HTML

    label.html_safe
  end
end
