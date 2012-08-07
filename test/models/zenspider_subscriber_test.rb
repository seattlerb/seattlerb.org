require 'test_helper'

describe ZenspiderSubscriber do

  it "has a name" do
    ZenspiderSubscriber.must_respond_to :subscribe!
  end

end