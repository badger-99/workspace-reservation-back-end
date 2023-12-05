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
    render json: { workspace: WorkspaceSerializer.new(@workspace).serializable_hash[:data][:attributes] }
  end

  def create
    @new_workspace = Workspace.new(workspace_params)
    if @new_workspace.save
      render json: { success: 'Workspace has been created.' }
    else
      render json: { error: 'workspace has not been created.' }
    end
  end

  def destroy
    @deleted_workspace = Workspace.find(params[:id])
    if @deleted_workspace.destroy
      render json: { success: 'workspace deleted' }
    else
      render json: { error: 'something went wrong' }
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :image)
  end
end
