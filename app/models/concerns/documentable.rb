module Documentable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_name
    validate_url(:url)
    validate_document_type
  end
end