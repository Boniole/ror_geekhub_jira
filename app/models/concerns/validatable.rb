module Validatable
  extend ActiveSupport::Concern

  RANGE_NAME_LENGTH = 2..30
  RANGE_DESC_LENGTH = 3..2500
  RANGE_EMAIL_LENGTH = 8..64
  RANGE_PASSWORD_LENGTH = 8..20
  RANGE_REPO_NAME_LENGTH = RANGE_NAME_LENGTH
  RANGE_LABEL_LENGTH = RANGE_NAME_LENGTH
  RANGE_COLUMN_NAMES = ['ToDo', 'In progress', 'In review', 'Done'].freeze
  RANGE_ALLOWED_TYPES = %w[pdf jpg jpeg png gif doc docx xls xlsx zip rar].freeze

  MAX_URL_LENGTH = 500

  REGEXP_USER = /\A[a-zA-Z]+\z/
  REGEXP_EMAIL = /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}\z/
  REGEXP_PASSWORD = /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/
  REGEXP_PHONE = /\A\+[0-9]{6,14}\z/
  REGEXP_TIME_PERIOD = /\A\d+(w|d|h|m)\z/
  REGEXP_GITHUB_TOKEN = /\A(ghp_[a-zA-Z0-9]{36}|github_pat_[a-zA-Z0-9]{22}_[a-zA-Z0-9]{59}|v[0-9]\.[0-9a-f]{40})\z/
  REGEXP_GIT_REPO = %r{\A\w+/\w+\z}
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
                }, if: :password_required?

      def password_required?
        new_record? || password.present?
      end
    end

    def self.validate_phone_number
      validates :phone_number, format: {
        with: REGEXP_PHONE,
        message: 'Invalid phone number. Please check your input and try again.'
      }, allow_blank: true
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

    def self.validate_url(field = :git_url)
      validates field, length: { maximum: MAX_URL_LENGTH },
                       format: {
                         with: REGEXP_GIT_URL,
                         message: 'Must be a valid URL'
                       }, allow_blank: true
    end

    def self.validate_document_type
      validates :document_type, presence: true,
                                inclusion: { in: RANGE_ALLOWED_TYPES, message: "File type %<value>s is not allowed. Allowed types are: #{RANGE_ALLOWED_TYPES.join(', ')}" }
    end
  end
end
