class Api::V2::AssigneeSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name
end
