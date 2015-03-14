module ApplicationHelper
  def alert_class
    alert ? 'bg-danger' : ''
  end

  def notice_class
    notice ? 'bg-success' : ''
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
