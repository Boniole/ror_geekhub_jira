class Api::V1::AssigneeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
end
