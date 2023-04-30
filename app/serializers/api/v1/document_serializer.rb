class Api::V1::DocumentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :name, :url
end
