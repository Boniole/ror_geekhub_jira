# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  deleted_at             :datetime
#  email                  :string
#  first_name             :string
#  github_token           :string
#  last_name              :string
#  password_digest        :string
#  phone_number           :string
#  provider               :string
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  uid                    :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_deleted_at  (deleted_at)
#
require 'rails_helper'

RANGE_PASSWORD_LENGTH = 8..20

RSpec.describe User, type: :model do
  it 'has many' do
    should have_many :memberships
    should have_many :projects
    should have_many :tasks
    should have_many :comments
    should have_many :documents
  end
  it { should validate_uniqueness_of(:email) }
  # it { should validate_exclusion_of(:password_digest).in_range(RANGE_PASSWORD_LENGTH) }
end
