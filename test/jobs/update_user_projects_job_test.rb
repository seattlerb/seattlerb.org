require_relative "job_test"

class UpdateUserProjectsJobTest < JobTest
  test "the truth" do
    projects = Project.count
    user = users(:one)
    user.projects.create! name: "fake4", url: "url" # to be removed

    user_projects = user.projects

    job = self.job
    def job.current_gems u
      o = { "info" => "this is a description", "project_uri" => "https://rubygems.org/gems/fake" }
      o.default_proc = ->(h,k) { raise "BAD: #{k}" }
      {
        "fake1" => o,
        "fake2" => o,
        "fake3" => o,
      }
    end

    c, u, d = job.perform user

    assert_equal 1, c.size # add fake3
    assert_equal 2, u.size # upd fake1-2
    assert_equal 1, d.size # del fake4

    assert_equal user_projects.count, user.reload.projects.count

    # TODO: tweak out the fixtures and test the updates

    exp = "this is a description"
    assert_equal exp, user.projects.find_by(name: "fake3").description
  end
end
