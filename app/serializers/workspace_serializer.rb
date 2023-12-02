class WorkspaceSerializer
  include JSONAPI::Serializer
  attributes :name, :description, :image, :created_at, :updated_at, :image_url
end
