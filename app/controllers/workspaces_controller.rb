class WorkspacesController < ApplicationController
  def index
    @workspaces = Workspace.all
  end

  def show
    @workspace = Workspace.find(params[:workspace_id])
  end

  def create
    @new_workspace = Workspace.new(workspace_params)
  end

  def destroy
    @deleted_workspace = Workspace.find(params[:workspace_id])
    # find all reservations with a foreign key similar to this Id and destroy them, then ...
    @deleted_workspace.destroy
  end

  private

  def workspace_params
    params.require(:workspace).permit(:name, :description, :image)
  end
end
