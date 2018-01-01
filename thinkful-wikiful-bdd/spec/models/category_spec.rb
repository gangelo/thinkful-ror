require 'rails_helper'

RSpec.describe Category, :type => :model do
  context "factories" do
    describe "#category" do
      subject { FactoryGirl.build(:category) }
      it { should be_valid }
    end
  end

  context "validations" do
    it { should ensure_length_of(:name).is_at_least(3) }
    it { should ensure_length_of(:name).is_at_most(16) }
  end

  context "associations" do
    it { should have_many :articles }
  end

end
