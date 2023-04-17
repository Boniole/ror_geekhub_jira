# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  git_repo    :string
#  git_url     :string
#  name        :string
#  status      :integer
#  tasks_count :integer          default(0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_projects_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Project < ApplicationRecord
  # CONST (concern)
  belongs_to :user
  has_many :desks, dependent: :destroy
  has_many :documents, as: :documentable
  has_many :memberships
  has_many :users, through: :memberships

  # length: { minimum: 3 } to const
  validates :name, presence: true, length: {in: 3..30 }
  validates :status, presence: true
  validates :git_url, length: { maximum: 255 },
                      format: {
                        with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                        message: 'must be a valid URL'
                      }, allow_blank: true
  validates :git_repo, length: { in: 3..30 }, allow_blank: true

  enum :status, %i[open close], default: :open

  after_create :create_desk

  private

  def create_desk
    desks.create
  end
end
