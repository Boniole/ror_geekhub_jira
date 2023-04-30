class Api::V1::MembershipSerializer < ActiveModel::Serializer
  attributes :user_id, :project_id, :role, :first_name, :email

  def first_name
    object.user.first_name
  end

  def email
    object.user.email
  end
end
