require 'rails_helper'

RSpec.describe Account, type: :model do
  let(:custom_account) { Account.new(account_type: 'custom') }
  let(:standard_account) { Account.new(account_type: 'standard', email: 'tester@test.com') }

  it { is_expected.to validate_presence_of(:account_type) }
  it { is_expected.to validate_inclusion_of(:account_type).in_array(%w(custom standard)) }

  describe "custom account type" do
    it "does not throw error for empty email" do
      expect(custom_account).to be_valid
    end
  end

  describe "standard account type with no email" do
    before do
      @standard_no_email = Account.new(account_type: 'standard')
    end

    it "throws error for empty email" do
      @standard_no_email.valid?
      expect(@standard_no_email.errors.full_messages).to eq ["Email can't be blank"]
    end
  end

  describe "valid standard account" do
    it "is valid" do
      expect(standard_account).to be_valid
    end
  end
end
