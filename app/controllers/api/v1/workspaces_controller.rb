class Api::V1::WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.all
    render json: { workspaces: @workspaces }
  end

  def show
    @workspace = Workspace.find(params[:id])
    render json: { workspaces: @workspace }
  end

  def create
    @new_workspace = Workspace.new(workspace_params)
  end

  def destroy
    @deleted_workspace = Workspace.find(params[:workspace_id])
    @deleted_workspace.destroy
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :image)
  end
end
