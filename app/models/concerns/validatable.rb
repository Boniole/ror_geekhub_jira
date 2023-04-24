module Validatable
  extend ActiveSupport::Concern

  RANGE_NAME_LENGTH = 2..30
  RANGE_DESC_LENGTH = 3..2500
  RANGE_EMAIL_LENGTH = 8..64
  RANGE_PASSWORD_LENGTH = 8..20
  RANGE_REPO_NAME_LENGTH = RANGE_NAME_LENGTH
  RANGE_LABEL_LENGTH = RANGE_NAME_LENGTH
  RANGE_COLUMN_NAMES = ['ToDo', 'In progress', 'In review', 'Done'].freeze


  MAX_GIT_URL_LENGTH = 255

  REGEXP_USER = /\A[a-zA-Z]+\z/.freeze
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/.freeze
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/.freeze
  REGEXP_TIME_PERIOD = /\A\d+(w|d|h|m)\z/.freeze
  REGEXP_GITHUB_TOKEN = /\A(ghp_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}|v[0-9]\.[0-9a-f]{40})\z/.freeze
  REGEXP_GIT_REPO = /\A\w+\/\w+\z/.freeze
  REGEXP_GIT_URL = URI::DEFAULT_PARSER.make_regexp(%w[http https])

  included do
    def self.validate_user_field(field = :first_name)
      validates field, presence: true,
                       length: { in: RANGE_NAME_LENGTH },
                       format: {
                         with: REGEXP_USER,
                         message: 'Only latin letters allowed, no spaces or special characters'
                       }
    end

    def self.validate_name(field = :name)
      validates field, presence: true, length: { in: RANGE_NAME_LENGTH }
    end

    def self.validate_description(field = :description)
      validates field, length: { in: RANGE_DESC_LENGTH }
    end

    def self.validate_email
      validates :email, presence: true,
                        uniqueness: true,
                        length: { in: RANGE_EMAIL_LENGTH },
                        format: {
                          with: REGEXP_EMAIL,
                          message: 'Should be in the format: user@domain.com'
                        }
    end

    def self.validate_password
      validates :password,
                presence: true,
                length: { in: RANGE_PASSWORD_LENGTH },
                format: {
                  with: REGEXP_PASSWORD,
                  message: 'Must contain at least one uppercase letter, one lowercase letter, and one digit'
                }, on: %i[create show show_current_user destroy]
    end

    def self.validate_time_period(field = :estimate)
      validates field,
                format: {
                  with: REGEXP_TIME_PERIOD,
                  message: 'is not in the valid format (e.g. 2w, 4d, 6h, 45m)'
                }, allow_blank: true
    end

    def self.validate_label
      validates :label, length: { in: RANGE_LABEL_LENGTH }, allow_blank: true
    end

    def self.validate_github_token
      validates :github_token,
                format: {
                  with: REGEXP_GITHUB_TOKEN,
                  message: 'Must be a valid GitHub personal access token!'
                }, allow_blank: true
    end

    def self.validate_git_repo
      validates :git_repo, length: { in: RANGE_REPO_NAME_LENGTH },
                           format: {
                             with: REGEXP_GIT_REPO,
                             message: 'Should be in the format username/reponame'
                           }, allow_blank: true
    end

    def self.validate_git_url
      validates :git_url, length: { maximum: MAX_GIT_URL_LENGTH },
                          format: {
                            with: REGEXP_GIT_URL,
                            message: 'Must be a valid URL'
                          }, allow_blank: true
    end
  end

  module Userable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_user_field
      validate_user_field(:last_name)
      validate_email
      validate_password
      validate_github_token
    end
  end

  module Projectable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_name
      validate_git_repo
      validate_git_url
    end
  end

  module Deskable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_name
    end
  end

  module Columnable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_name
    end
  end

  module Taskable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_name
      validate_description
      validate_time_period
      validate_time_period(:time_work)
      validate_label
    end
  end

  module Commentable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_description(:body)
    end
  end

  module Documentable
    extend ActiveSupport::Concern
    include Validatable

    included do
      validate_name
    end
  end
end
