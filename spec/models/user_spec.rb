require 'spec_helper'

describe User do
  before { @user = create(:user) }
  subject { @user }

  it { should validate_uniqueness_of(:email) }
  it { should validate_presence_of(:email) }

  it "generates an api_token" do
    expect(@user.api_token).not_to be_nil
  end

  context "when email format is invalid" do
    it "should be invalid" do
      @user.email = 'user@foo,com'
      expect(@user).not_to be_valid
      @user.email = 'user_at_foo.org'
      expect(@user).not_to be_valid
      @user.email = 'example.user@foo.'
      expect(@user).not_to be_valid
      @user.email = 'foo@bar_baz.com'
      expect(@user).not_to be_valid
      @user.email = 'foo@bar+baz.com'
      expect(@user).not_to be_valid
      @user.email = 'user@foo,com'
      expect(@user).not_to be_valid
    end
  end

  describe "#refresh_api_token!" do
    it "should change the current api_token" do
      last_api_token = @user.api_token
      @user.refresh_api_token!
      expect(@user.api_token).to_not eq last_api_token
    end
  end

end
