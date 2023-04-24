# == Schema Information
#
# Table name: columns
#
#  id             :bigint           not null, primary key
#  name           :text
#  ordinal_number :integer          default(0)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  desk_id        :bigint           not null
#
# Indexes
#
#  index_columns_on_desk_id  (desk_id)
#
# Foreign Keys
#
#  fk_rails_...  (desk_id => desks.id)
#
require 'rails_helper'

RSpec.describe Column, type: :model do
  it { should have_many :tasks }
  it { should belong_to :desk }

  it { should validate_numericality_of :ordinal_number }
end
