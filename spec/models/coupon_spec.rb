require 'rails_helper'

RSpec.describe Coupon, type: :model do
  it { is_expected.to validate_presence_of(:duration) }
  it { is_expected.to validate_presence_of(:amount_off) }
  it { is_expected.to validate_presence_of(:currency) }

  it { is_expected.to validate_length_of(:currency).is_equal_to(3) }
  it { is_expected.to validate_inclusion_of(:duration).in_array(%w(forever once repeating)) }
end
