# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  has_secure_password

  has_many :projects, dependent: :destroy
  has_many :desks
  has_many :tasks

  validates :name, presence: true
  validates :password, presence: true
end
