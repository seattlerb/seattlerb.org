require_relative "job_test"

class ReviewUserJobTest < JobTest
  make_my_diffs_pretty!

  def user = (@u ||= users :one)
  def checks = (@c ||= [])

  def setup
    super
    reviews(:one).delete # not relevant

    job = self.job

    checks = self.checks
    job.define_singleton_method :try_url do |url, msg=nil|
      raise "no" if url =~ /bad/
      checks << url
    end
  end

  test "sanity check" do
    # runs on a user, clears their reviews, checks website+rubygems+github
    result = job.perform user

    assert_equal user, result
    assert_empty user.reload.reviews

    exp = [
      "http://www.zenspider.com/",
      "https://rubygems.org/api/v1/profiles/fake",
      "https://api.github.com/users/fake",
    ]

    assert_equal exp, checks
  end

  def assert_reviews exp, user
    reviews = user.reload.reviews.map { |r| r.attributes.values_at(*exp.keys) }
    assert_equal [exp.values], reviews
  end

  test "reviews website" do
    user.website = "bad"
    user.save

    result = job.perform user

    assert_equal user, result
    exp = {
      "field"   => "website",
      "message" => "no",
      "url"     => "bad",
    }
    assert_reviews exp, user
  end

  test "reviews rubygems" do
    user.rubygems_name = "bad"
    user.save

    result = job.perform user

    assert_equal user, result
    exp = {
      "field"   => "rubygems",
      "message" => "no",
      "url"     => "https://rubygems.org/api/v1/profiles/bad",
    }
    assert_reviews exp, user
  end

  test "reviews github" do
    user.github_name = "bad"
    user.save

    result = job.perform user

    assert_equal user, result

    exp = {
      "field"   => "github",
      "message" => "no",
      "url"     => "https://api.github.com/users/bad",
    }
    assert_reviews exp, user
  end

end
