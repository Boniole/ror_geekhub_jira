# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :string
#  end_date    :text
#  estimate    :text
#  label       :text
#  priority    :integer          default("low")
#  sort_number :integer
#  start_date  :text
#  status      :integer          default("open")
#  tag_name    :text
#  title       :text
#  type_of     :integer          default("task")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  assignee_id :integer
#  column_id   :bigint
#  desk_id     :bigint           not null
#  project_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_column_id   (column_id)
#  index_tasks_on_desk_id     (desk_id)
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (column_id => columns.id)
#  fk_rails_...  (desk_id => desks.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
