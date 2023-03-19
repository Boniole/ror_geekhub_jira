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
#  status      :integer
#  title       :text
#  type        :integer          default(0)
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
  belongs_to :column, as: :polymorphic
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :comments, as: :polymorphic, dependent: :destroy

  enum :priority, %i[lowest low high highest], default: :lowest
  enum :type, %i[task bug epic], default: :task
  enum :status, %i[open close], default: :open

  validates :user_id, numericality: { only_integer: true }
  validates :project_id, numericality: { only_integer: true }
  validates :desk_id, numericality: { only_integer: true }

  validates :title, presence: true, length: { in: 3..30 }
  validates :description, presence: true, length: { in: 3..2500 }
  validates :label, presence: true, optional: true
  validates :start, presence: true, date: true, optional: true
  validates :end, presence: true, date: true, optional: true
  validates :estimate, datetime: { allow_blank: true }
end
