require 'rails_helper'

RSpec.describe Plan, type: :model do
  it { is_expected.to validate_presence_of(:currency) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:interval) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:interval_count) }

  it { is_expected.to validate_length_of(:currency).is_equal_to(3) }
  it { is_expected.to validate_length_of(:statement_descriptor).is_at_most(22) }
end
