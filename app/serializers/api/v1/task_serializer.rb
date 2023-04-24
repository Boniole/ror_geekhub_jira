# == Schema Information
#
# Table name: tasks
#
#  id              :bigint           not null, primary key
#  description     :string
#  end_date        :text
#  estimate        :text
#  label           :text
#  name            :text
#  priority        :integer
#  priority_number :integer
#  start_date      :text
#  status          :integer
#  tag_name        :text
#  type_of         :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  assignee_id     :integer
#  column_id       :bigint           not null
#  desk_id         :bigint           not null
#  project_id      :bigint           not null
#  user_id         :bigint           not null
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
class Api::V1::TaskSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :assignee, :name, :description, :tag_name, :priority_number, :estimate, :time_work, :label,
             :priority, :type_of, :status, :start_date, :end_date, :created_at, :updated_at

  has_one :assignee, serializer: Api::V1::AssigneeSerializer
  has_many :comments, each_serializer: Api::V1::CommentSerializer
end
