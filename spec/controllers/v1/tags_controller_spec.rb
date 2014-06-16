require 'spec_helper'

describe V1::TagsController do
  let(:attributes_returned_as_json) { %w[id title] }
  let(:not_available_id)            { 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11' }

  context "authorized" do
    before { auth_with(create(:user)) }

    describe "#index" do
      let!(:tags) { create_list(:tag, 5) }

      context "when tags found" do
        before { get :index }

        it "returns http success" do
          response.should be_success
        end

        it "should respond with 5 tags" do
          expect(json['tags']).to have(5).items
        end

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            json['tags'].size.times do |i|
              expect(json['tags'][i]).to have_key(key)
            end
          end
        end
      end
    end

    describe "#show" do
      let(:tag) { create(:tag) }

      context "when tag was found" do
        before { get :show, id: tag.id }

        it { expect(json).to have_key('tag') }

        it "should respond with right fields" do
          attributes_returned_as_json.each do |key|
            expect(json['tag']).to have_key(key)
          end
        end
      end

      context "when tag was not found" do
        before { get :show, id: not_available_id }

        it "returns not found" do
          response.status.should eq 404
        end
      end
    end

    describe "#create" do
      let(:post_create) { post :create, tag: attributes }
      context "with valid attributes" do
        let(:attributes) { attributes_for(:tag) }

        it "creates tag" do
          expect { post_create }.to change(Tag, :count).by(1)
        end
      end

      context "with invalid attributes" do
        let(:attributes) { {} }

        it "does not create tag" do
          expect { post_create }.not_to change(Tag, :count)
        end
      end
    end

    describe "#update" do
      let(:tag) { create(:tag) }
      let(:patch_update) { patch :update, id: tag.to_param, tag: attributes }

      context "with valid attributes" do
        let(:attributes) { attributes_for(:tag) }

        it "creates tag" do
          patch_update
          response.should be_success
        end
      end

      context "with invalid attributes" do
        let(:attributes) { { title: '' } }

        it "does not create tag" do
          patch_update
          response.status.should eq(422)
        end
      end

      context "non-existing tag" do
        let(:attributes) { attributes_for(:tag) }

        it "does not create tag" do
          patch :update, id: not_available_id, tag: attributes
          response.status.should eq(404)
        end
      end
    end

    describe "#destroy" do
      let!(:tag) { create(:tag) }

      context "existing tag" do
        it "destroys tag" do
          expect{
            delete :destroy, id: tag.to_param
          }.to change(Tag, :count)
        end
      end

      context "non-existing tag" do
        it "does not destroy tag" do
          expect{
            delete :destroy, id: not_available_id
          }.not_to change(Tag, :count)
        end
      end
    end
  end
end
