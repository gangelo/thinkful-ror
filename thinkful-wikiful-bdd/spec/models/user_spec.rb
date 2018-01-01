require 'rails_helper'

RSpec.describe User, :type => :model do
  context "factories" do
    describe "#user" do
      subject { FactoryGirl.build(:user) }
      it { should be_valid }
    end
  end

  context "validations" do
    it { should ensure_length_of(:name).is_at_least(4) }
    it { should ensure_length_of(:name).is_at_most(32) }

    it { should ensure_length_of(:user_name).is_at_least(4) }
    it { should ensure_length_of(:user_name).is_at_most(16) }
    it { should validate_uniqueness_of :user_name }

    it { should ensure_length_of(:email).is_at_least(3) }
    it { should ensure_length_of(:email).is_at_most(254) }
    it { should validate_uniqueness_of :email }
    it { should allow_value("email@good.com").for(:email) }
    it { should_not allow_value("email.bad.com").for(:email) }

    it { should ensure_length_of(:password).is_at_least(6) }
    it { should ensure_length_of(:password).is_at_most(16) }
    it { should validate_confirmation_of :password }
    it { should allow_value("Gene$0").for(:password) }
    it { should_not allow_value("Gene0").for(:password) }
  end

  context "associations" do
    it { should have_many :articles}
  end

  context "class methods" do
    let(:user) { FactoryGirl.create(:user) }

    describe ".account_exists? returns true if user already exists" do  
      subject { User.account_exists?(user) }
      it { is_expected.to eq(true) }
    end

    describe ".account_exists? returns true if user_name already exists" do  
      before {
        user.email = 'does.not.exist@nowhere.com'
      }
      subject { User.account_exists?(user) }
      it { is_expected.to eq(true) }
    end

    describe ".account_exists? returns true if email already exists" do  
      before {
        user.user_name = 'doesNotExist'
      }
      subject { User.account_exists?(user) }
      it { is_expected.to eq(true) }
    end
  end
end
