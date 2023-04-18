# == Schema Information
#
# Table name: comments
#
#  id               :bigint           not null, primary key
#  body             :string
#  commentable_type :string           not null
#  status           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  commentable_id   :bigint           not null
#  user_id          :bigint           not null
#
# Indexes
#
#  index_comments_on_commentable  (commentable_type,commentable_id)
#  index_comments_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Api::V1::CommentSerializer < ActiveModel::Serializer
  attributes :id, :status, :body, :user, :created_at, :updated_at

  # need check
  def user
    Api::V1::UserSerializer.new(object.user).attributes
  end
end
