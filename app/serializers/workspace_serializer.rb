class WorkspaceSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :image_url
end
