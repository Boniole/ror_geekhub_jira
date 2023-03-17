# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  body            :string
#  commetable_type :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  commetable_id   :bigint           not null
#  task_id         :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_comments_on_commetable  (commetable_type,commetable_id)
#  index_comments_on_task_id     (task_id)
#  index_comments_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
