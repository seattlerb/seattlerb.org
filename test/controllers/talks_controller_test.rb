require "minitest_helper"

class TalksControllerTest < MiniTest::Rails::ActionController::TestCase
  def setup
    @talk = Talk.create!(:title       => "My Test Talk",
                         :description => "Description",
                         :kind        => "beginner",
                         :email       => "a@example.com",
                         :presenter   => "Me")
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
    @past_one = Talk.create!(:title     => "Past 1",
                            :kind      => "lightning",
                            :email     => "a@example.com",
                            :presenter => "Me",
                            :description => "Description",
                            :completed => true)
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

  def test_past
    setup_talks

    get :past
    assert_response :success

    assert_equal [@past_one], assigns[:talks]

    assert_match @past_one.title,       @response.body
    assert_match @past_one.presenter,   @response.body
    assert_match @past_one.description, @response.body
    assert_match @past_one.kind,        @response.body

  end

  def test_talks_sorted_on_event_date_kind_and_title
    setup_talks

    @beg_two.event = Event.create date: 2.month.from_now
    @int_two.event = Event.create date: 27.days.from_now
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

  def test_talks_sorted_on_index_and_event_date
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
    talk_attributes =               {:title       => "Title",
                                     :presenter   => "The Dude",
                                     :kind        => "beginner",
                                     :email       => "a@example.com",
                                     :description => "My description"}

    admin_optin1    =  Admin.create!(:email             => "rubyadmin1@gmail.com",
                                     :password          => "password123",
                                     :talk_notification => true)

    admin_optin2    =  Admin.create!(:email             => "rubyadmin2@gmail.com",
                                     :password          => "password123",
                                     :talk_notification => true)

    admin_optout    =  Admin.create!(:email             => "rubyadmin_optout@gmail.com",
                                     :password          => "password123")

    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      assert_difference 'Talk.count', 1 do
        post :create, :talk => talk_attributes, :password => ""
        assert_redirected_to talks_path
      end
    end

    mail = ActionMailer::Base.deliveries.last

    assert_match /noreply@seattlerb.org/, mail.from.first
    assert_match /Seattle.rb Talk Notification/, mail.subject
    assert mail.to.include?("rubyadmin1@gmail.com")
    assert mail.to.include?("rubyadmin2@gmail.com")
    assert !mail.to.include?("rubyadmin_optout@gmail.com")
    assert_match /beginner/, mail.encoded
    assert_match /Title/, mail.encoded
    assert_match /a@example.com/, mail.encoded
    assert_match /The Dude/, mail.encoded
    assert_match /My description/, mail.encoded

    get :index
    assert_response :success

    talk = Talk.find_by_title("Title")

    refute_nil talk
    assert_equal "Title",          talk.title
    assert_equal "My description", talk.description
    assert_equal "beginner",       talk.kind
    assert_equal "The Dude",       talk.presenter

    assert_match @talk.title,       @response.body
    assert_match @talk.presenter,   @response.body
    assert_match @talk.description, @response.body
    assert_match @talk.kind,        @response.body
  end

  def test_create_fails_without_spam_blocker
    talk_attributes = {
                       :title       => "Title",
                       :presenter   => "The Dude",
                       :kind        => "beginner",
                       :email       => "a@example.com",
                       :description => "My description",
                      }


    assert_difference 'Talk.count', 0 do
      post :create, :talk => talk_attributes, :password => "spammer"
    end

    assert_redirected_to root_path
  end

  def test_create_fails_with_special_requests_spam_trap
    talk_attributes = {
                       :title       => "Title",
                       :presenter   => "The Dude",
                       :kind        => "beginner",
                       :email       => "a@example.com",
                       :description => "My description",
                       :special_talk_requests => "My special request"
                      }


    assert_difference 'Talk.count', 0 do
      post :create, :talk => talk_attributes, :password => ""
    end

    assert_redirected_to talks_path
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
