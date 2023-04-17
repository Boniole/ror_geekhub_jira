class GithubRepository
  include ActiveModel::API

  # https://api.rubyonrails.org/classes/ActiveModel/Validator.html
  attr_accessor :project_id, :name, :description, :private, :has_issues, :has_downloads

  validates :project_id, numericality: { only_integer: true }
  validates :name, length: { in: 3..30 }
  validates :description, length: { in: 3..2500 }, allow_blank: true
  validates :private, inclusion: [true, false]
  validates :has_issues, inclusion: [true, false]
  validates :has_downloads, inclusion: [true, false]
end
