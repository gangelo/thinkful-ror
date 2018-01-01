require 'rails_helper'

RSpec.describe ArticleCategory, :type => :model do
  context "factories" do
    describe "#article_category" do
      subject { FactoryGirl.build(:article_category) }
      it { should be_valid }
    end
  end

  context "associations" do
    it { should belong_to :article }
    it { should belong_to :category }
  end
end
