require 'rails_helper'

RSpec.describe GithubRepository, type: :model do
  it { should validate_numericality_of(:project_id) }
  it { should validate_length_of(:name).is_at_least(3).on(:create) }
  it { should validate_length_of(:name).is_at_most(30).on(:create) }
  it { should validate_length_of(:description).is_at_least(3).on(:create) }
  it { should validate_length_of(:description).is_at_most(2500).on(:create) }

  it { should validate_inclusion_of(:private).in_array([true, false]) }
  it { should validate_inclusion_of(:has_issues).in_array([true, false]) }
  it { should validate_inclusion_of(:has_downloads).in_array([true, false]) }
end