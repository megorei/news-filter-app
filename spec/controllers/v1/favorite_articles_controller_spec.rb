require 'spec_helper'

describe V1::FavoriteArticlesController do
  let(:attributes_returned_as_json) { %w[id user_id article_id] }
  let(:not_available_id) { SecureRandom.uuid }

  context "authorized" do
    before { auth_with(create(:user)) }

    describe "#index" do
      let!(:favorite_articles) { create_list(:favorite_article, 5) }

      context "when favorite_articles found" do
        before { get :index }

        it "returns http success" do
          response.should be_success
        end

        it "should respond with 5 favorite_articles" do
          expect(json['favorite_articles']).to have(5).items
        end

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            json['favorite_articles'].size.times do |i|
              expect(json['favorite_articles'][i]).to have_key(key)
            end
          end
        end
      end
    end

    describe "#show" do
      let(:favorite_article) { create(:favorite_article) }

      context "when favorite_article was found" do
        before { get :show, id: favorite_article.id }

        it { expect(json).to have_key('favorite_article') }

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            expect(json['favorite_article']).to have_key(key)
          end
        end
      end

      context "when favorite_article was not found" do
        before { get :show, id: not_available_id }

        it "returns not found" do
          response.status.should eq 404
        end
      end
    end

    describe "#create" do
      let(:post_create) { post :create, favorite_article: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:favorite_article) }

        it "creates favorite_article" do
          expect { post_create }.to change(FavoriteArticle, :count).by(1)
        end
      end
    end

    describe "#update" do
      let(:favorite_article) { create(:favorite_article) }
      let(:patch_update) { patch :update, id: favorite_article.to_param, favorite_article: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:favorite_article) }

        it "creates favorite_article" do
          patch_update
          response.should be_success
        end
      end

      context "non-existing favorite_article" do
        let(:attributes) { attributes_for(:favorite_article) }

        it "does not create favorite_article" do
          patch :update, id: not_available_id, favorite_article: attributes
          response.status.should eq(404)
        end
      end
    end

    describe "#destroy" do
      let!(:favorite_article) { create(:favorite_article) }

      context "existing favorite_article" do
        it "destroys favorite_article" do
          expect {
            delete :destroy, id: favorite_article.to_param
          }.to change(FavoriteArticle, :count)
        end
      end

      context "non-existing favorite_article" do
        it "does not destroy favorite_article" do
          expect {
            delete :destroy, id: not_available_id
          }.not_to change(FavoriteArticle, :count)
        end
      end
    end
  end
end
