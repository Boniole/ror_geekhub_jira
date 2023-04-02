# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  documentable_type :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  documentable_id   :bigint           not null
#
# Indexes
#
#  index_documents_on_documentable  (documentable_type,documentable_id)
#
class Document < ApplicationRecord
  belongs_to :documentable, polymorphic: true

  has_many_attached :files
end
