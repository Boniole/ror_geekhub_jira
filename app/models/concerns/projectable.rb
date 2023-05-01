module Projectable
  extend ActiveSupport::Concern
  include Validatable

  included do
    validate_name
    validate_git_repo
    validate_url
  end

  def restore_desks
    self.desks.only_deleted.each { |desk| desk.restore }
  end

  def create_desk
    desks.create
  end
end