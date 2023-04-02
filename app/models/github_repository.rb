class GithubRepository
  include ActiveModel::API

  attr_accessor :name, :description, :private, :has_issues, :has_downloads
# debugger
p '123123123123213123'
  validates :name, length: { in: 3..30 }
  validates :description, presence: true, length: { in: 3..2500 }, allow_blank: true
  validates :private, presence: true, inclusion: [true, false]
  validates :has_issues, presence: true, inclusion: [true, false]
  validates :has_downloads, presence: true, inclusion: [true, false]

  
    def initialize(attributes={})
    super
    @omg ||= true
  end

end
