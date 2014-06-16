require 'spec_helper'

describe V1::FeedsController do
  let(:attributes_returned_as_json) { %w[id title url user_id] }
  let(:not_available_id)            { 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' }

  context "authorized" do
    before { auth_with(create(:user)) }

    describe "#index" do
      let!(:feeds) { create_list(:feed, 5) }

      context "when feeds found" do
        before { get :index }

        it "returns http success" do
          response.should be_success
        end

        it "should respond with 5 feeds" do
          expect(json['feeds']).to have(5).items
        end

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            json['feeds'].size.times do |i|
              expect(json['feeds'][i]).to have_key(key)
            end
          end
        end
      end
    end

    describe "#show" do
      let(:feed) { create(:feed) }

      context "when feed was found" do
        before { get :show, id: feed.id }

        it { expect(json).to have_key('feed') }

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            expect(json['feed']).to have_key(key)
          end
        end
      end

      context "when feed was not found" do
        before { get :show, id: not_available_id }

        it "returns not found" do
          response.status.should eq 404
        end
      end
    end

    describe "#create" do
      let(:post_create) { post :create, feed: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:feed) }

        it "creates feed" do
          expect { post_create }.to change(Feed, :count).by(1)
        end
      end

      context "with invalid attributes" do
        let(:attributes) { {} }

        it "does not create feed" do
          expect { post_create }.not_to change(Feed, :count)
        end
      end
    end

    describe "#update" do
      let(:feed) { create(:feed, user: current_user) }
      let(:patch_update) { patch :update, id: feed.to_param, feed: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:feed) }

        it "creates feed" do
          patch_update
          response.should be_success
        end
      end

      context "with invalid attributes" do
        let(:attributes) { { title: '' } }

        it "does not create feed" do
          patch_update
          response.status.should eq(422)
        end
      end

      context "non-existing feed" do
        let(:attributes) { attributes_for(:feed) }

        it "does not create feed" do
          patch :update, id: not_available_id, feed: attributes
          response.status.should eq(404)
        end
      end
    end

    describe "#destroy" do
      let!(:feed) { create(:feed, user: current_user) }

      context "existing feed" do
        it "destroys feed" do
          expect{
            delete :destroy, id: feed.to_param
          }.to change(Feed, :count)
        end
      end

      context "non-existing feed" do
        it "does not destroy feed" do
          expect{
            delete :destroy, id: not_available_id
          }.not_to change(Feed, :count)
        end
      end
    end
  end
end
