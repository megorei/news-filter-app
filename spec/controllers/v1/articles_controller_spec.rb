require 'spec_helper'

describe V1::ArticlesController do
  let(:attributes_returned_as_json) { %w[id title url description feed_id] }
  let(:not_available_id)            { 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' }

  context "authorized" do
    before { auth_with(create(:user)) }

    describe "#index" do
      let!(:articles) { create_list(:article, 5) }

      context "when articles found" do
        before { get :index }

        it "returns http success" do
          response.should be_success
        end

        it "should respond with 5 articles" do
          expect(json['articles']).to have(5).items
        end

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            json['articles'].size.times do |i|
              expect(json['articles'][i]).to have_key(key)
            end
          end
        end
      end
    end

    describe "#show" do
      let(:article) { create(:article) }

      context "when article was found" do
        before { get :show, id: article.id }

        it { expect(json).to have_key('article') }

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            expect(json['article']).to have_key(key)
          end
        end
      end

      context "when article was not found" do
        before { get :show, id: not_available_id }

        it "returns not found" do
          response.status.should eq 404
        end
      end
    end
  end
end
