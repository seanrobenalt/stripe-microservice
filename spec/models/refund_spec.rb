require 'rails_helper'

RSpec.describe Refund, type: :model do
  it { is_expected.to validate_presence_of(:charge_id) }
  it { is_expected.to validate_inclusion_of(:reason).in_array(%w(duplicate fraudulent requested_by_customer)) }
end
