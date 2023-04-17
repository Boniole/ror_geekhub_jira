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
class Task < ApplicationRecord
  include Validatable::Name
  include Validatable::Description

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

  # range constant
  # with: /\A\d+(w|d|h|m)\z/ to const
  validates :label, length: { in: 3..30 }, allow_blank: true
  validates :estimate, format: {
    with: /\A\d+(w|d|h|m)\z/,
    message: 'is not in the valid format (e.g. 2w, 4d, 6h, 45m)'
  }, allow_blank: true

  validates_format_of :start_date, :end_date, with: /\A(20[2-9]\d|2[1-2]\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])\z/,
                                              message: 'must be in the format YYYY-MM-DD',
                                              allow_blank: true

  validate :start_and_end_dates_are_valid

  before_create :generate_tag_name
  after_create :increment_project_task_count
  #after_update :set_sort_number , if: -> {sotr_number.nil?} set_priority_number
  before_save :set_priority_number

  private

  # validates :dated_on, :date => {:after => Proc.new { Time.now + 2.years },
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
    #self?
    self.tag_name = "#{first_project_letter}P-#{project.tasks_count}"
  end

  def set_priority_number
    #self?
    self.priority_number = column.tasks.maximum(:priority_number).to_i + 1 if priority_number.nil?
  end
end
