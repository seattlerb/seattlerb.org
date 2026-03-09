require_relative "job_test"

class CullOrphansJobTest < JobTest
  test "the truth" do
    # add a project w/ no ties to anyone, run job, should be gone

    orphan = Project.create! name: "orphans", url: "https://github/fake/fake"

    job = self.job

    result = job.perform

    assert_empty Project.where name: "orphans"
  end
end
