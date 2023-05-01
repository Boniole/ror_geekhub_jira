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
FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Travolta' }
    email { Random.hex(5)+'@gmail.com'}
    password { 'Hh'+Random.hex(7) }
  end
end