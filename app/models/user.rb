# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string
#  first_name             :string
#  github_token           :string
#  last_name              :string
#  password_digest        :string
#  provider               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  include Validatable::Userable

  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable

  has_many :memberships
  has_many :projects, through: :memberships

  # think about (enum)
  def admin?(project)
    project.memberships.find_by(user_id: id)&.role == 'admin'
  end

  # self?
  # PASSWORDABLE
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
# to controller or concerns
  # omniauthable
  def self.from_omniauth(auth)
    find_or_create_by(provider: auth[:provider], uid: auth[:uid]) do |user|
      user.provider = auth[:provider]
      user.uid = auth[:uid]
      user.first_name = auth[:info][:first_name]
      user.last_name = auth[:info][:last_name]
      user.email = auth[:info][:email]
      user.password = SecureRandom.hex(15)
    end
  end

  private

  # PASSWORDABLE
  def generate_token
    SecureRandom.hex(10)
  end
end

# CONCERNS
# https://blog.appsignal.com/2020/09/16/rails-concers-to-concern-or-not-to-concern.html
