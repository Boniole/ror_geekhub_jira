# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :string
#  end         :date
#  estimate    :datetime
#  label       :text
#  priority    :integer
#  start       :date
#  title       :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  assignee_id :integer
#  desk_id     :bigint           not null
#  project_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_desk_id     (desk_id)
#  index_tasks_on_project_id  (project_id)
#  index_tasks_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (user_id => users.id)
#
class Task < ApplicationRecord
  belongs_to :project
  belongs_to :desk
  belongs_to :user
  has_many :comments, dependent: :destroy
end
