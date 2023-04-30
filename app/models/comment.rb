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
class Comment < ApplicationRecord
  include Validatable::Commentable

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :documents, as: :documentable, dependent: :destroy

  enum :status, %i[open close], default: :open

  scope :current_comment, ->(user_id, comment_id) { joins(:user).where(user_id: user_id).find(comment_id) }
end
