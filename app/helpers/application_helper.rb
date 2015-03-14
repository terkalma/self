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
end
