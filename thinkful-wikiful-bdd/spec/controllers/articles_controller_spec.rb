  require 'rails_helper'

  RSpec.describe ArticlesController, :type => :controller do
    before (:each) do
      @created_at = DateTime.now
    end

    context "list actions" do
      before (:each) do
        @articles = 4.times.map { |x| FactoryGirl.create(:article, created_at: @created_at - x.day) }
      end

      describe "GET index" do
        it "returns a list of all articles, ordered by created_at date, desc" do
          get :index
          expect(assigns(:articles)).to eq([@articles[0], @articles[1], @articles[2], @articles[3]])
          expect(response).to be_success
        end
      end

      describe "GET show" do
        it "returns the article requested, based on the passed article id" do
          get :show, { id: @articles[2].id }
          expect(assigns(:articles)).to eq(@articles[2])
          expect(response).to be_success
        end
      end

    end

    describe "GET show" do
      it "redirects to article_path if an article cannot be found for the passed article id" do
        get :show, { id: -1 }
        expect(response).to redirect_to(articles_path)
      end
    end

    describe "GET new" do
      it "returns a new article" do
        force_current_user?
        get :new
        expect(assigns(:article)).to be_a_new(Article)
      end
    end

    describe "POST create" do
      it "creates a new article" do
        force_current_user FactoryGirl.create(:user)
        article = FactoryGirl.build(:article, title: 'title', content: 'content').attributes.symbolize_keys
        post :create, { article: { title: article[:title], content: article[:content], category_ids: [1] } }
        expect(response).to redirect_to(articles_path(Article.first))
        # Why isn't this working? expect { Article.count }.to change { Article.count }.by(1)
      end
    end

    describe "POST author" do
      it "returns a list of articles for the author based on author user " do
        articles = nil
        user = FactoryGirl.create(:user) do |user|
          articles = 4.times.map { |x| FactoryGirl.create(:article, user: user, created_at: DateTime.now - x.days) }
        end
        post :author, author: user.name
        expect(assigns(:articles)).to eq(articles)
      end
    end

    describe "POST date" do
      it "returns a list of all articles for the author by article published date" do
        published_date = (@created_at - 10.years).utc
        articles = 10.times.map { |x| FactoryGirl.create(:article, created_at: published_date) }
        post :date, date: published_date
        expect(assigns(:articles)).to eq(articles)
      end
    end

    describe "GET articles_autocomplete_authors" do
      it "returns authors given a search token" do
        term = 'Howdy H. Doody'
        # Create some users...
        30.times { FactoryGirl.create(:user) }
        FactoryGirl.create(:user, name: term)
        FactoryGirl.create(:user, name: "X#{term}X")
        10.times.map { |x|
          FactoryGirl.create(:user, name: "#{x.to_s}X#{term}") 
          FactoryGirl.create(:user, name: "#{x.to_s}X#{term}X#{x.to_s}") 
          FactoryGirl.create(:user, name: "#{term}X#{x.to_s}") 
        }
        30.times { FactoryGirl.create(:user) }
        users = User.order(name: :asc).select(:id, 'name AS label ').where("name like ?", "%#{term}%") 
        get :autocomplete_authors , term: term, format: :json
        expect(response.body).to eq(users.to_json)
      end
    end

  end
