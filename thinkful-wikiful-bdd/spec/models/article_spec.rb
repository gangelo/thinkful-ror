require 'rails_helper'

RSpec.describe Article, :type => :model do
  context "factories" do
    describe "#artcle" do
      subject { FactoryGirl.build(:article) }
      it { should be_valid }
    end
  end

  context "validations" do
    it { should ensure_length_of(:title).is_at_least(3) }
    it { should ensure_length_of(:title).is_at_most(128) }

    it { should ensure_length_of(:content).is_at_least(3) }
    it { should ensure_length_of(:content).is_at_most(64000) }
  end

  context "associations" do
    it { should belong_to :user}
    it { should have_many :categories }
  end

  context "class methods" do
    let(:user) { 
      FactoryGirl.create(:user) do |user| 
        10.times.map{ FactoryGirl.create(:article, user: user) }
      end 
    }

    describe ".find_by_author_id" do
      it "should return all author articles" do
        articles = user.articles.map(&:id)
        expect(Article.find_by_author_id(user.id).map(&:id).sort).to eq(articles.sort)
      end
    end

    describe ".find_by_author_user_name" do
      it "should return all author articles" do
        articles = user.articles.map(&:id)
        expect(Article.find_by_author_user_name(user.user_name).map(&:id).sort).to eq(articles.sort)
      end

      it "should ignore user name case, and return all author articles" do
      end
    end

    describe ".find_by_author_name" do
      it "should return all author articles" do
        articles = user.articles.map(&:id)
        expect(Article.find_by_author_name(user.name).map(&:id).sort).to eq(articles.sort)
      end

      it "should ignore user name case, and return all author articles" do
      end
    end

    describe ".find_by_date_published" do
      let(:date_time_now) { DateTime.new(2014, 1, 1).change(hour: 12, minute: 0, second: 0); }

      before(:each) do
        5.times do
          FactoryGirl.create(:user) do |user| 
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.year) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.month) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.day) 
            # Start - articles that should be returned by .find_by_date_published
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.hour) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.minute) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now - 1.second) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.second) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.minute) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.hour) 
            # End - articles that should be returned by .find_by_date_published
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.day) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.month) 
            FactoryGirl.create(:article, user: user, created_at: date_time_now + 1.year) 
          end 
        end
      end

      it "should return all articles for the given date (day/month/year)" do
        # Note: 7 maching articles * 5 users = 35 matching articles.
        expect(Article.find_by_date_published(date_time_now).count).to eq(35)
      end
    end
  end

  context "categories" do
    let (:article) { FactoryGirl.create(:article) }
    before { article.categories.delete_all }
    it "at least one category must be associated with every article" do
      expect(article).to_not be_valid
    end
  end
end