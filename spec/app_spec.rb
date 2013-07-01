require 'spec_helper'

describe 'App' do
  it "should respond to GET for a random image" do
    get '/'
    last_response.should be_ok
    # last_response.body.should match(/*.jpg/)
  end
end