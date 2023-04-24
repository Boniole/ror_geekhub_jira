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
require 'rails_helper'

RSpec.describe Comment, type: :model do
  it { should belong_to :user }
  it { should belong_to :commentable }
  it { should have_many :documents }
  it { should define_enum_for(:status).with_values([:open, :close]) }
  # it { should validate_exclusion_of(:body).in_range(3..2500)}
  # it { should validate_presence_of(:body) }
  # it { should validate_presence_of(:user) }
  # it { should validate_presence_of(:commentable) }

end
