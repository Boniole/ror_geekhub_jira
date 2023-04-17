module Validatable
  extend ActiveSupport::Concern

  RANGE_NAME_LENGTH = 2..30
  RANGE_DESC_LENGTH = 3..2500
  RANGE_EMAIL_LENGTH = 8..64
  RANGE_PASSWORD_LENGTH = 8..20
  RANGE_REPO_NAME_LENGTH = RANGE_NAME_LENGTH
  RANGE_LABEL_LENGTH = RANGE_NAME_LENGTH

  MAX_GIT_URL_LENGTH = 255

  REGEXP_USER = /\A[a-zA-Z]+\z/
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/
  REGEXP_ESTIMATE = /\A\d+(w|d|h|m)\z/
  REGEXP_DATE = /\A(20[2-9]\d|2[1-2]\d{2})-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01])\z/
  REGEXP_GITHUB_TOKEN =/\A(ghp_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}|v[0-9]\.[0-9a-f]{40})\z/
  REGEXP_GIT_URL = URI::DEFAULT_PARSER.make_regexp(%w[http https])

  module Name
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :name, presence: true, length: { in: RANGE_NAME_LENGTH }
    end
  end

  module Description
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :description, length: { in: RANGE_DESC_LENGTH }
    end
  end

  module Body
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :body, length: { in: RANGE_DESC_LENGTH }
    end
  end

  module FirstName
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :first_name, presence: true,
                             length: { in: RANGE_NAME_LENGTH },
                             format: {
                               with: REGEXP_USER,
                               message: 'Only latin letters allowed, no spaces or special characters'
                             }
    end
  end

  module LastName
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :last_name, presence: true,
                            length: { in: RANGE_NAME_LENGTH },
                            format: {
                              with: REGEXP_USER,
                              message: 'Only latin letters allowed, no spaces or special characters'
                            }
    end
  end

  module Email
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :email, presence: true, uniqueness: true,
                        length: { in: RANGE_EMAIL_LENGTH },
                        format: {
                          with: REGEXP_EMAIL,
                          message: 'Should be in the format: user@domain.com'
                        }
    end
  end

  module Password
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :password,
                presence: true,
                length: { in: RANGE_PASSWORD_LENGTH },
                format: {
                  with: REGEXP_PASSWORD,
                  message: 'Must contain at least one uppercase letter, one lowercase letter, and one digit'
                }
    end
  end

  module Estimate
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :estimate,
                format: {
                  with: REGEXP_ESTIMATE,
                  message: 'is not in the valid format (e.g. 2w, 4d, 6h, 45m)'
                }, allow_blank: true
    end
  end

  module FormatDate
    extend ActiveSupport::Concern
    include Validatable

      # TODO validates :dated_on, :date => {:after => Proc.new { Time.now + 2.years },
  #                                  :before => Proc.new { Time.now - 2.years } }

    included do
      validates_format_of :start_date, :end_date, with: REGEXP_DATE, message: 'must be in the format YYYY-MM-DD', allow_blank: true
    end
  end

  module Label
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :label, length: { in: RANGE_LABEL_LENGTH }, allow_blank: true
    end
  end

  module GitHubToken
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :github_token,
                format: {
                  with: REGEXP_GITHUB_TOKEN,
                  message: 'Must be a valid GitHub personal access token!'
                }, allow_blank: true
    end
  end

  module GitRepo
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :git_repo, length: { in: RANGE_REPO_NAME_LENGTH }, allow_blank: true
    end
  end

  module GitUrl
    extend ActiveSupport::Concern
    include Validatable

    included do
      validates :git_url, length: { maximum: MAX_GIT_URL_LENGTH },
      format: {
        with: REGEXP_GIT_URL,
        message: 'must be a valid URL'
      }, allow_blank: true
    end
  end
end
