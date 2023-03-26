# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  last_name              :string
#  name                   :string
#  password_digest        :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks
  has_many :comments, as: :commentable, dependent: :destroy

  has_many :memberships
  has_many :projects, through: :memberships

  validates :name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true,
                    length: { minimum: 8, maximum: 64 },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true,
                       length: { minimum: 8, maximum: 20 },
                       format: { with: /\A(?=.*\d)(?=.*[a-z])(?=.*[A-Z])[a-zA-Z0-9]+\z/,
                                 message: 'must contain at least one uppercase letter, one lowercase letter, and one digit' }

  def admin?(project)
    project.memberships.find_by(user_id: id)&.role == 'admin'
  end

  def generate_password_token!
    self.reset_password_token = generate_token
    self.reset_password_sent_at = Time.now.utc
    save!(validate: false)
  end

  def password_token_valid?
    (reset_password_sent_at + 4.hours) > Time.now.utc
  end

  def reset_password!(password)
    self.reset_password_token = nil
    self.password = password
    save!(validate: false)
  end

  private

  def generate_token
    SecureRandom.hex(10)
  end
end
