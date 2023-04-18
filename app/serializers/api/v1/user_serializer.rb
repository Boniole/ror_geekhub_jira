# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  first_name             :string
#  github_token           :string
#  last_name              :string
#  password_digest        :string
#  provider               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email

  has_many :projects, each_serializer: Api::V1::ProjectSerializer
  has_many :comments, each_serializer: Api::V1::CommentSerializer
end
