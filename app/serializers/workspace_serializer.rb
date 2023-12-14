class WorkspaceSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :description, :price_per_day, :image_url
end
