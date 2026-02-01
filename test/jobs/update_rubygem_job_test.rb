require_relative "job_test"

class UpdateRubygemJobTest < JobTest
  test "the truth" do
    job = self.job
    def job.try_url url, msg # valid
      url
    end

    info = {
      "homepage_uri" => "https://github.com/fake/fake",
      "info"         => "this is a new description",
    }

    project = projects :fake1
    result = job.perform project, info

    assert_kind_of Project, result

    assert_equal info["homepage_uri"], result.url
    assert_equal info["info"],         result.description

    assert_equal 0, result.reviews.count
  end

  test "handles errors by creating review" do
    job = self.job
    def job.try_url url, msg
      raise "No"
    end

    info = {
      "homepage_uri" => "https://github.com/fake/fake",
      "info"         => "this is a new description",
    }

    project = projects :fake1
    result = job.perform project, info

    assert_kind_of Review, result

    # assert_equal info["homepage_uri"], result.url
    # assert_equal info["info"],         result.description

    assert_equal 1, project.reviews.count

    assert_equal project, result.reference
    assert_equal "rubygem_info", result.field
    assert_match /NOT NULL/, result.message
  end
end
