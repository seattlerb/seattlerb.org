require_relative "job_test"

class ReviewProjectJobTest < JobTest
  test "the truth" do
    job = self.job
    def job.check_url m, f, u
      "body"
    end

    project = projects :fake1

    result = job.perform project

    assert_kind_of Project, result
  end

  test "handles errors" do
    job = self.job
    def job.check_url m, f, u
      raise "bad url"
    end

    project = projects :fake1

    result = job.perform project

    assert_kind_of Review,  result
    assert_equal project,   result.reference
    assert_equal "url",     result.field
    assert_equal "bad url", result.message
  end
end
