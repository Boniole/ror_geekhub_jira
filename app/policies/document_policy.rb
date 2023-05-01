class DocumentPolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    member?(project_of_documentable)
  end

  def update?
    @record.user == user || admin?(project_of_documentable)
  end

  alias create? show?
  alias destroy? update?

  def project_of_documentable
    case @record.documentable_type
    when 'Project'
      @record.documentable.id
    when 'Task'
      @record.documentable.project_id
    when 'Comment'
      @record.documentable.commentable.project_id
    end
  end
end
