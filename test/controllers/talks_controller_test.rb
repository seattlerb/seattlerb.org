require "minitest_helper"

class TalksControllerTest < MiniTest::Rails::ActionController::TestCase
  def setup
    @talk = Talk.create!(:title         => "My Test Talk",
                         :description   => "Description",
                         :kind          => "beginner",
                         :email         => "a@example.com",
                         :presenter     => "Me",
                         :proposed_date => Talk.proposable_dates.first)
  end

  def setup_talks
    @int_one = Talk.create!(:title     => "Int 1",
                            :kind      => "intermediate",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @int_two = Talk.create!(:title     => "Int 2",
                            :kind      => "intermediate",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @beg_one = Talk.create!(:title     => "Beg 1",
                            :kind      => "beginner",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @beg_two = Talk.create!(:title     => "Beg 2",
                            :kind      => "beginner",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @adv_one = Talk.create!(:title     => "Adv 1",
                            :kind      => "advanced",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @adv_two = Talk.create!(:title     => "Adv 2",
                            :kind      => "advanced",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @lit_one = Talk.create!(:title     => "Lit 1",
                            :kind      => "lightning",
                            :email     => "a@example.com",
                            :presenter => "Me")
    @lit_two = Talk.create!(:title     => "Lit 2",
                            :kind      => "lightning",
                            :email     => "a@example.com",
                            :presenter => "Me")
  end

  def test_index
    get :index
    assert_response :success

    assert assigns[:talks].include?(@talk)

    assert_match @talk.title,       @response.body
    assert_match @talk.presenter,   @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind,        @response.body
  end

  def test_talks_sorted_on_scheduled_date_kind_and_title
    setup_talks

    @beg_two.scheduled_date = 2.month.from_now
    @int_two.scheduled_date = 27.days.from_now
    @beg_two.save
    @int_two.save

    get :index

    expected = [@int_two,
                @beg_one, @talk,
                @int_one,
                @adv_one, @adv_two,
                @lit_one, @lit_two].map(&:title)

    assert_equal expected, assigns[:talks].map(&:title)
  end

  def test_talks_sorted_on_index_and_date
    setup_talks

    get :index

    expected = [@beg_one, @beg_two, @talk,
                @int_one, @int_two,
                @adv_one, @adv_two,
                @lit_one, @lit_two].map(&:title)

    assert_equal expected, assigns[:talks].map(&:title)
  end

  def test_talks_only_available
    setup_talks

    @adv_two.completed = true
    @beg_two.completed = true
    @int_two.completed = true
    @lit_two.completed = true
    @talk.completed    = true

    [@adv_two, @beg_two, @int_two, @lit_two, @talk].map(&:save!)

    get :index

    expected = [@beg_one, @int_one, @adv_one, @lit_one].map(&:title)

    assert_equal expected, assigns[:talks].map(&:title)
  end

  def test_create
    assert_difference 'Talk.count', 1 do
      post :create, :talk => @talk.attributes, :password => ""
      assert_redirected_to talks_path
    end

    get :index
    assert_response :success

    talk = Talk.find_by_title(@talk.title)

    refute_nil talk
    assert_equal @talk.title,          talk.title
    assert_equal @talk.description,    talk.description
    assert_equal @talk.kind,           talk.kind
    assert_equal @talk.presenter,      talk.presenter
    assert_equal @talk.proposed_date,  talk.proposed_date

    assert_match talk.title,       @response.body
    assert_match talk.presenter,   @response.body
    assert_match talk.description, @response.body
    assert_match talk.kind,        @response.body
  end

  def test_create_fails_without_spam_blocker
    assert_difference 'Talk.count', 0 do
      post :create, :talk => @talk.attributes, :password => "spammer"
    end

    assert_redirected_to root_path
  end

  def test_create_fails_with_invalid_proposed_date
    @talk.proposed_date = Date.new(2014).next_week(:friday)
    assert_difference 'Talk.count', 0 do
      post :create, :talk => @talk.attributes, :password => ""
    end

    assert_template :index
  end

  def test_unknown_talk_404s
    assert_raises(ActiveRecord::RecordNotFound) do
      get :show, :id => "derp"
    end
  end

  def test_talk_accessible_at_linkable_page
    get :show, :id => @talk.id
    assert_response :success
    assert_equal assigns[:talk], @talk
  end

  def test_talk_components_in_view
    get :show, :id => @talk.id

    assert_match @talk.title,       @response.body
    assert_match @talk.presenter,   @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind,        @response.body
  end

  def test_disqus_shortname_assigned
    get :show, :id => @talk.id
    assert_equal assigns[:disqus_shortname], "seattlerb"
  end

end
