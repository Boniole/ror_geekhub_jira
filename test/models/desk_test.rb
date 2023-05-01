# == Schema Information
#
# Table name: desks
#
#  id            :bigint           not null, primary key
#  columns_count :integer          default(0), not null
#  deleted_at    :datetime
#  name          :string           default("Your Desk")
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  project_id    :bigint           not null
#
# Indexes
#
#  index_desks_on_deleted_at  (deleted_at)
#  index_desks_on_project_id  (project_id)
#
# Foreign Keys
#
#  fk_rails_...  (project_id => projects.id)
#
require "test_helper"

class DeskTest < ActiveSupport::TestCase

end
