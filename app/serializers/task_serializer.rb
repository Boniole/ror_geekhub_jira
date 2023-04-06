# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  column_type :string           not null
#  description :string
#  end         :text
#  estimate    :text
#  label       :text
#  priority    :integer          default("low")
#  start       :text
#  status      :integer          default("open")
#  title       :text
#  type_of     :integer          default("task")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  assignee_id :integer
#  column_id   :bigint           not null
#  desk_id     :bigint           not null
#  project_id  :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_tasks_on_column      (column_type,column_id)
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
class TaskSerializer < ActiveModel::Serializer
  attributes :user, :column, :title, :description, :estimate, :label, :priority, :type_of, :status, :start, :end, :created_at, :updated_at

  has_one :user, serializer: UserSerializer
  has_one :assignee, serializer: AssigneeSerializer
  has_one :column, serializer: ColumnSerializer
end
