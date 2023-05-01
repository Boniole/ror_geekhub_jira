module Commentable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_description(:body)
  end
end