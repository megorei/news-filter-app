require 'spec_helper'

describe V1::SessionsController do

  describe "#POST create" do
    let(:password) { "test" }
    let(:user) { create(:user, password: password) }

    context "valid authentication data" do
      it "responds with api token and user id" do
        post :create, session: {email: user.email, password: password}
        response.should be_success
        json['session'].should have_key('api_token')
        json['session'].should have_key('user_id')
      end
    end

    context "invalid authentication data" do
      it "responds with authentication error" do
        post :create, session: {email: user.email, password: 'wrong password'}
        response.status.should eq(422)
      end
    end
  end
end
