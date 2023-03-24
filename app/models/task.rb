# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  column_type :string           not null
#  description :string
#  end         :date
#  estimate    :datetime
#  label       :text
#  priority    :integer          default("low")
#  start       :date
#  status      :integer          default("open")
#  title       :text
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
class Task < ApplicationRecord
  belongs_to :project
  belongs_to :desk
  belongs_to :column, polymorphic: true
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :comments, as: :commentable, dependent: :destroy

  enum :priority, %i[low high highest], default: :low
  enum :type_of, %i[task bug epic], default: :task
  enum :status, %i[open close], default: :open

  validates :user_id, numericality: { only_integer: true }
  validates :project_id, numericality: { only_integer: true }
  validates :desk_id, numericality: { only_integer: true }

  validates :title, length: { in: 3..30 }
  validates :description, presence: true, length: { in: 3..2500 }, allow_blank: true
  validates :label, presence: true, length: { in: 3..30 }, allow_blank: true
  validates :estimate, format: {
    with: /\A\d+(w|d|h|m)\z/,
    message: 'is not in the valid format (e.g. 2w, 4d, 6h, 45m)'
  }, allow_blank: true

  current_year = Time.now.year
  validates_format_of :start, :end, with: /\A(#{current_year})-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])\z/,
    message: 'must be in the format YYYY-MM-DD and current year',
    allow_blank: true
end
