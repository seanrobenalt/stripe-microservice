require 'rails_helper'

RSpec.describe Transfer, type: :model do
  it { is_expected.to validate_presence_of(:currency) }
  it { is_expected.to validate_presence_of(:amount) }
  it { is_expected.to validate_presence_of(:destination) }

  it { is_expected.to validate_length_of(:currency).is_equal_to(3) }
end
