class Api::V1::WorkspacesController < Api::V1::ApplicationController
  skip_before_action :authenticate_request, only: %i[index show]

  def index
    @workspaces = Workspace.all
    render json: { workspaces: WorkspaceSerializer.new(@workspaces).serializable_hash[:data].map do |item|
                                 item[:attributes]
                               end }, status: :ok
  end

  def show
    @workspace = Workspace.find(params[:id])
    if @workspace
      render json: { workspace: WorkspaceSerializer.new(@workspace).serializable_hash[:data][:attributes] }, status: :ok
    else
      render json: { error: 'Workspace does not exist' }, status: :not_found
    end
  end

  def create
    @new_workspace = Workspace.new(workspace_params)
    if @new_workspace.save
      render json: { success: 'Workspace has been created.',
                     workspace: {
                       id: @new_workspace.id,
                       name: @new_workspace.name,
                       description: @new_workspace.description,
                       price_per_day: @new_workspace.price_per_day
                     } }, status: :created
    else
      render json: { error: 'workspace has not been created.' }, status: :bad_request
    end
  end

  def destroy
    @deleted_workspace = Workspace.find(params[:id])
    if @deleted_workspace.destroy
      render json: { success: 'workspace deleted' }, status: :ok
    else
      render json: { error: 'something went wrong' }, status: :not_found
    end
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :price_per_day, :image)
  end
end
