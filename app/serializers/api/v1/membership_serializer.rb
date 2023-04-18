class Api::V1::MembershipSerializer < ActiveModel::Serializer
  attributes :user_id, :project_id, :role
end
