require 'rails_helper'

RSpec.describe Customer, type: :model do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:card_number) }
  it { is_expected.to validate_presence_of(:exp_year) }
  it { is_expected.to validate_presence_of(:exp_month) }
  it { is_expected.to validate_presence_of(:cvc) }
end
