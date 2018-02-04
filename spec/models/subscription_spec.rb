require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { is_expected.to validate_presence_of(:cus_id) }
  it { is_expected.to validate_presence_of(:plan_id) }
end
