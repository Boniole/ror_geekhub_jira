# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  github_token           :string
#  last_name              :string
#  name                   :string
#  password_digest        :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :last_name, :email

  has_many :comments, each_serializer: CommentSerializer
end
