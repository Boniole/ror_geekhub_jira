# == Schema Information
#
# Table name: memberships
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  role       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_memberships_on_deleted_at  (deleted_at)
#  index_memberships_on_project_id  (project_id)
#  index_memberships_on_user_id     (user_id)
#
require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :user }
  it { should belong_to :project }

  it { should define_enum_for(:role).with_values([:member, :admin]) }
end
