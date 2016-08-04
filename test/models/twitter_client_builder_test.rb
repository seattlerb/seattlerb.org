require "minitest_helper"

class TwitterClientBuilderTest < ActiveSupport::TestCase
  def test_build_client
    assert_instance_of Twitter::REST::Client, TwitterClientBuilder.build
  end
end
