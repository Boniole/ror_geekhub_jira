class GithubRepository
  include ActiveModel::API

  attr_accessor :name, :description, :private, :has_issues, :has_downloads

  validates :name, length: { in: 3..30 }
  validates :description, presence: true, length: { in: 3..2500 }, allow_blank: true
  validates :private, inclusion: [true, false]
  validates :has_issues, inclusion: [true, false]
  validates :has_downloads, inclusion: [true, false]
end
