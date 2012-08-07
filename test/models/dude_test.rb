require 'test_helper'

describe Dude do

  it "has a name" do
    Dude.new.valid?.must_equal false
  end

end