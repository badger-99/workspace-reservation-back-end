class Api::V1::WorkspacesController < Api::V1::ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]

  def index
    @workspaces = Workspace.all
    render json: { workspaces: WorkspaceSerializer.new(@workspaces).serializable_hash[:data].map do |item|
                                 item[:attributes]
                               end }
  end

  def show
    @workspace = Workspace.find(params[:id])
    render json: { workspaces: @workspace }
  end

  def create
    @new_workspace = Workspace.new(workspace_params)
    if @new_workspace.save
      render json: { success: 'Workspace has been created' }
    else
      render json: { errors: @new_workspace.errors.full_messages }
    end
  end

  def destroy
    @deleted_workspace = Workspace.find(params[:workspace_id])
    @deleted_workspace.destroy
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :image)
  end

  def serialized_workspaces
    @workspaces.map do |workspace|
      {
        id: workspace.id,
        name: workspace.name,
        description: workspace.description,
        image_data: workspace.image
      }
    end
  end
end
