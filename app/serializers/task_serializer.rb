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
class TaskSerializer < ActiveModel::Serializer
  attributes :id, :user, :assignee, :title, :description, :tag_name, :sort_number, :estimate, :label, :priority,
             :type_of, :status, :start_date, :end_date, :created_at, :updated_at

  has_one :user, serializer: UserSerializer
  has_one :assignee, serializer: AssigneeSerializer
  has_many :comments, each_serializer: CommentSerializer
end
