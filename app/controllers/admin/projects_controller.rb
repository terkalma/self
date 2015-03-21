class Admin::ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create

  end

  def edit
    @project = Project.find_by_slug params[:id]
  end

  def update

  end
end
