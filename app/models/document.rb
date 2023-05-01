# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  deleted_at        :datetime
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
#  index_documents_on_deleted_at    (deleted_at)
#  index_documents_on_documentable  (documentable_type,documentable_id)
#  index_documents_on_user_id       (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Document < ApplicationRecord
  include Validatable::Documentable

  belongs_to :documentable, polymorphic: true
  belongs_to :user

  has_one_attached :file
end
