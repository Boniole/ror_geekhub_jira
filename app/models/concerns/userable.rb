module Userable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_user_field
    validate_user_field(:last_name)
    validate_email
    validate_phone_number
    validate_password
    validate_github_token
  end

  def restore_projects
    projects.only_deleted.each(&:restore)
  end
end
