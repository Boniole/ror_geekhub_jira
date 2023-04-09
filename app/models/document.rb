# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  document_type     :string           not null
#  documentable_type :string           not null
#  name              :string           not null
#  url               :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  documentable_id   :bigint           not null
#  user_id           :bigint
#
# Indexes
#
#  index_documents_on_documentable  (documentable_type,documentable_id)
#  index_documents_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Document < ApplicationRecord
  ALLOWED_TYPES = %w[pdf jpg jpeg png gif doc docx xls xlsx zip rar]
  belongs_to :documentable, polymorphic: true

  belongs_to :user

  has_one_attached :file

  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :document_type, presence: true, inclusion: { in: ALLOWED_TYPES, message: "File type %{value} is not allowed. Allowed types are: #{ALLOWED_TYPES.join(', ')}" }
  validates :url, presence: true, format: { with: URI.regexp }
end
