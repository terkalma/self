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

  def licence_link
    url = 'http://www.wtfpl.net/'
    img_url = 'http://www.wtfpl.net/wp-content/uploads/2012/12/wtfpl-badge-4.png'

    <<-HTML
      <a href=#{url}> <img src=#{img_url} width="80" height="15" alt="WTFPL"/> </a>
    HTML
  end
end
