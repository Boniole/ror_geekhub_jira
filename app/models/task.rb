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

  validate :start_and_end_dates_are_valid

  before_create :generate_tag_name
  after_create :increment_project_task_count

  private

  # TODO validates :dated_on, :date => {:after => Proc.new { Time.now + 2.years },
  #                                  :before => Proc.new { Time.now - 2.years } }
  def start_and_end_dates_are_valid
    return unless parse_date([start_date, end_date])

    errors.add(:errors, 'must be equal to or greater than the current date')
  end

  def parse_date(dates)
    parsed_dates = dates.map { |date| Date.parse(date) }
    parsed_dates.any? { |date| date.present? && date < Date.today }
  end

  def increment_project_task_count
    project.increment!(:tasks_count)
  end

  def generate_tag_name
    first_project_letter = Translit.convert(project.name[0], :english).upcase
    self.tag_name = "#{first_project_letter}P-#{project.tasks_count}"
  end
end
