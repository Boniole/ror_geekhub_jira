class Api::V1::AssigneeSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name
end
