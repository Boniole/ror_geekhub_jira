# == Schema Information
#
# Table name: documents
#
#  id            :bigint           not null, primary key
#  document_type :string           not null
#  name          :string           not null
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  comment_id    :bigint
#  project_id    :bigint           not null
#  task_id       :bigint
#  user_id       :bigint           not null
#
# Indexes
#
#  index_documents_on_comment_id  (comment_id)
#  index_documents_on_project_id  (project_id)
#  index_documents_on_task_id     (task_id)
#  index_documents_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (comment_id => comments.id)
#  fk_rails_...  (project_id => projects.id)
#  fk_rails_...  (task_id => tasks.id)
#  fk_rails_...  (user_id => users.id)
#
class Document < ApplicationRecord
  ALLOWED_TYPES = %w[pdf jpg jpeg png gif doc docx xls xlsx ppt pptx zip rar]

  belongs_to :project
  belongs_to :user
  belongs_to :task, optional: true
  belongs_to :comment, optional: true

  has_one_attached :document

  # validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  # validates :document_type, presence: true, inclusion: { in: ALLOWED_TYPES, message: "File type %{value} is not allowed. Allowed types are: #{ALLOWED_TYPES.join(', ')}" }
  # validates :url, presence: true, format: { with: URI.regexp }

  def file_url
    Rails.application.routes.url_helpers.rails_blob_url(self.file, only_path: true)
  end
end
