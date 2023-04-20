require 'rails_helper'

RSpec.describe Membership, type: :model do
  it { should belong_to :user }
  it { should belong_to :project }

  it { should define_enum_for(:role).with_values([:member, :admin]) }
end