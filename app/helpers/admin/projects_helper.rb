module Admin::ProjectsHelper
  def remove_user_options
    {
        method: :patch,
        data: { confirm: 'Are you sure?' },
        role: 'button',
        class: 'btn btn-default',
    }
  end
end
