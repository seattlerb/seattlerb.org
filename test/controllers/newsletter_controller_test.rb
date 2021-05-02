require "minitest_helper"

class NewsletterControllerTest < ActionController::TestCase
  def test_subscribe_to_discussion
    mock = MiniTest::Mock.new
    params = ActionController::Parameters.new('email' => 'a@email.com').permit!
    mock.expect :call, nil, [params]

    ZenspiderSubscriber.stub :subscribe_to_discussion, mock do
      post :subscribe, params: { :subscribe => {:person => {:email => 'a@email.com'}, :subscribe_to_discussion => "1"} }
    end

    assert_mock mock

    assert_redirected_to join_us_path
  end

  def test_subscribe_to_jobs
    mock = MiniTest::Mock.new
    params = ActionController::Parameters.new('email' => 'a@email.com').permit!
    mock.expect :call, nil, [params]

    ZenspiderSubscriber.stub :subscribe_to_jobs, mock do
      post :subscribe, params: { :subscribe => {:person => {:email => 'a@email.com'}, :subscribe_to_jobs => "1"} }
    end

    assert_mock mock

    assert_redirected_to join_us_path
  end
end
