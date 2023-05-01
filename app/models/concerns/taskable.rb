module Taskable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_name
    validate_description
    validate_time_period
    validate_time_period(:time_work)
    validate_label
  end

  def restore_comments
    Comment.all_comments_task(self).only_deleted.each { |comment| comment.restore }
  end
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
