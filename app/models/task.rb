# == Schema Information
#
# Table name: tasks
#
#  id              :bigint           not null, primary key
#  description     :string
#  end_date        :date
#  estimate        :text
#  label           :text
#  name            :text
#  priority        :integer
#  priority_number :integer
#  start_date      :date
#  status          :integer
#  tag_name        :text
#  time_work       :string
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
class Task < ApplicationRecord
  include Validatable::Taskable

  belongs_to :project
  belongs_to :desk
  belongs_to :column
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable, dependent: :destroy

  enum :priority, %i[lowest low high highest], default: :low
  enum :type_of, %i[task bug epic], default: :task
  enum :status, %i[open close], default: :open

  validates_comparison_of :start_date, greater_than_or_equal_to: Date.today
  validates_comparison_of :end_date, greater_than: :start_date, other_than: Date.today

  before_create :generate_tag_name
  after_create :increment_project_task_count, :set_priority_number

  def increment_project_task_count
    project.increment!(:tasks_count)
  end

  def set_priority_number
    self.priority_number = column.tasks.maximum(:priority_number).to_i + 1 if priority_number.nil?
  end

  def generate_tag_name
    first_project_letter = Translit.convert(project.name[0], :english).upcase
    self.tag_name = "#{first_project_letter}P-#{project.tasks_count}"
  end
end
