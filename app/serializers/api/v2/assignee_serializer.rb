class Api::V2::AssigneeSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name
end
