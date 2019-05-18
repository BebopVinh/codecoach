class ResourcesController < ApplicationController
  before_action :current_user
  before_action :resource, only:[:show, :edit, :update]
  before_action :logged_in?
  before_action :mentor_logged_in?, only: [:new, :create, :edit]

  def new
    @resource = Resource.new
  end

  def index
    @resources = @current_user.resources.sort_by{|resource| resource.language }
  end

  def create
    if !params[:resource][:subfield][:name].empty?
      subfield = Subfield.find_or_create_by(name: params[:resource][:subfield][:name].strip)
      subfield.language_id = params[:resource][:language_id]
      subfield.save

      params[:resource][:subfield_id] = subfield.id
    end

    @resource = Resource.new(resource_params)

    if @resource.save
      redirect_to mentor_resource_path(@current_user, @resource)
    else
      render 'new'
    end
  end

  def top_resources
    @top_resources = Resource.top_resources
  end

  def edit
  end

  def update
    @resource.update(resource_params)

    redirect_to student_or_mentor_resources_path(@current_user)
  end

  private

  def resource_params
    params.require(:resource).permit(:website, :title, :url, :language_id, :subfield_id, :mentor_id, :read, :student_rating)
  end

  def resource
    @resource = Resource.find_by_id(params[:id])
  end
end
