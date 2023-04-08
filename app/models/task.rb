# == Schema Information
#
# Table name: tasks
#
#  id          :bigint           not null, primary key
#  description :string
#  end         :text
#  estimate    :text
#  label       :text
#  priority    :integer          default("low")
#  sort_number :integer
#  start       :text
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
class Task < ApplicationRecord
  belongs_to :project
  belongs_to :desk
  belongs_to :column
  belongs_to :user
  belongs_to :assignee, class_name: 'User', optional: true
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, dependent: :destroy

  enum :priority, %i[lowest low high highest], default: :low
  enum :type_of, %i[task bug epic], default: :task
  enum :status, %i[open close], default: :open

  validates :user_id, numericality: { only_integer: true }
  validates :project_id, numericality: { only_integer: true }
  validates :desk_id, numericality: { only_integer: true }
  validates :column_id, numericality: { only_integer: true }

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

  before_create :generate_tag_name
  after_create :increment_project_task_count
  before_save :set_sort_number

  private

  def increment_project_task_count
    project.increment!(:tasks_count)
  end

  def generate_tag_name
    first_project_letter = Translit.convert(project.name[0], :english).upcase
    self.tag_name = "#{first_project_letter}P-#{project.tasks_count}"
  end

  def set_sort_number
    if self.sort_number.nil?
      self.sort_number = self.column.tasks.maximum(:sort_number).to_i + 1
    end
  end
end
