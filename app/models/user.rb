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
  has_many :task_comments, -> { where(commentable_type: 'Task') }, class_name: 'Comment', foreign_key: :commentable_id
  has_many :documents, dependent: :destroy

  has_many :memberships
  has_many :membered_projects, through: :memberships, source: :project

  def admin?(project)
    id == project.user_id
  end
end
