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
  # CONSTANT length: { in: 3..2500 }
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :documents, as: :documentable, dependent: :destroy

  enum :status, %i[open close], default: :open

  # { in: 3..2500 } to constant
  validates :body, presence: true, length: { in: 3..2500 }
end
