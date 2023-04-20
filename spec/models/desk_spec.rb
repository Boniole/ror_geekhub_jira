# == Schema Information
#
# Table name: desks
#
#  id         :bigint           not null, primary key
#  name       :string           default("Your Desk")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  project_id :bigint           not null
#
# Indexes
#
#  index_desks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require 'rails_helper'

RSpec.describe Desk, type: :model do
  it { should have_many :columns }
  it { should belong_to :project }
end