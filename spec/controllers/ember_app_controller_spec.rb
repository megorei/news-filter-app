require 'spec_helper'

describe EmberAppController do

  describe "GET 'index'" do
    it "returns http success" do
      controller.stub(:authenticate).and_return(true)
      get 'index'
      response.should be_success
    end
  end

end
