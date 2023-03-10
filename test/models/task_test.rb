# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  title       :text
#  description :string
#  priority    :integer
#  status      :integer
#  label       :text
#  estimate    :datetime
#  start       :date
#  end         :date
#  assignee_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
