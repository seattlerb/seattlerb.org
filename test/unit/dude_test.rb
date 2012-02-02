require 'test_helper'

describe Dude do

  before do
    @dude = Dude.new(:ruby_gems_id  => 'foo')
  end

  it "should have a required ruby_gems_id" do
    @dude.ruby_gems_id.wont_be_empty
  end
end

