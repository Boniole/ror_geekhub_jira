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
  include Passwordable

  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :documents, as: :documentable

  has_many :memberships
  has_many :projects, through: :memberships

  # think about simplify (+ enum)
  def admin?(project)
    id == project.user_id
  end
end

# CONCERNS
# https://blog.appsignal.com/2020/09/16/rails-concers-to-concern-or-not-to-concern.html
