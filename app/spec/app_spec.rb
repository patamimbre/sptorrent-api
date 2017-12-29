require_relative 'spec_helper.rb'
require 'json'

describe "check correct responses" do

  it "/status should return status" do
    exp = {'status'=>'OK'}
    get '/status'
    json = JSON.parse(last_response.body)
    assert last_response.ok?
    assert json.must_equal exp
  end

  it "/ should return status" do
    exp = {'status'=>'OK'}
    get '/'
    json = JSON.parse(last_response.body)
    assert last_response.ok?
    assert json.must_equal exp
  end
end

