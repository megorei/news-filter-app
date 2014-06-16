require 'spec_helper'

describe V1::TaggedFeedsController do
  let(:attributes_returned_as_json) { %w[id feed_id tag_id] }
  let(:not_available_id) { SecureRandom.uuid }

  context "authorized" do
    before { auth_with(create(:user)) }

    describe "#index" do
      let!(:tagged_feeds) { create_list(:tagged_feed, 5) }

      context "when tagged_feeds found" do
        before { get :index }

        it "returns http success" do
          response.should be_success
        end

        it "should respond with 5 tagged_feeds" do
          expect(json['tagged_feeds']).to have(5).items
        end

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            json['tagged_feeds'].size.times do |i|
              expect(json['tagged_feeds'][i]).to have_key(key)
            end
          end
        end
      end
    end

    describe "#show" do
      let(:tagged_feed) { create(:tagged_feed) }

      context "when tagged_feed was found" do
        before { get :show, id: tagged_feed.id }

        it { expect(json).to have_key('tagged_feed') }

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            expect(json['tagged_feed']).to have_key(key)
          end
        end
      end

      context "when tagged_feed was not found" do
        before { get :show, id: not_available_id }

        it "returns not found" do
          response.status.should eq 404
        end
      end
    end

    describe "#create" do
      let(:post_create) { post :create, tagged_feed: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:tagged_feed) }

        it "creates tagged_feed" do
          expect { post_create }.to change(TaggedFeed, :count).by(1)
        end
      end
    end

    describe "#update" do
      let(:tagged_feed) { create(:tagged_feed) }
      let(:patch_update) { patch :update, id: tagged_feed.to_param, tagged_feed: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:tagged_feed) }

        it "creates tagged_feed" do
          patch_update
          response.should be_success
        end
      end

      context "non-existing tagged_feed" do
        let(:attributes) { attributes_for(:tagged_feed) }

        it "does not create tagged_feed" do
          patch :update, id: not_available_id, tagged_feed: attributes
          response.status.should eq(404)
        end
      end
    end

    describe "#destroy" do
      let!(:tagged_feed) { create(:tagged_feed) }

      context "existing tagged_feed" do
        it "destroys tagged_feed" do
          expect {
            delete :destroy, id: tagged_feed.to_param
          }.to change(TaggedFeed, :count)
        end
      end

      context "non-existing tagged_feed" do
        it "does not destroy tagged_feed" do
          expect {
            delete :destroy, id: not_available_id
          }.not_to change(TaggedFeed, :count)
        end
      end
    end
  end
end
