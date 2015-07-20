class ProjectDataTable < BaseDataTable
  delegate :edit_admin_project_path, to: :@view

  def initialize(view:, relation: nil)
    super view: view, relation:  relation || Project
  end

  private
  def header
    %w[name created_at]
  end

  def map_resource(project)
    [
        link_to(project.name, edit_admin_project_path(project)),
        project.created_at.to_s
    ]
  end

  def default_sort_column
    'name'
  end
end
