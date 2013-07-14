require File.expand_path(File.dirname(__FILE__)) + '/helper'

include Rack::Test::Methods

def app
  OmniTokenApp
end

describe 'OmniToken app' do
  it "should show the home page" do
    get '/'
    assert_equal 200, last_response.status
  end
end
