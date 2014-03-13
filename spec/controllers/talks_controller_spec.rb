require 'spec_helper'

describe TalksController do
  let(:talk){ Talk.create!(:title       => "My Test Talk",
                           :description => "Description",
                           :kind        => "beginner",
                           :email       => "a@example.com",
                           :presenter   => "Me")
            }
  let(:int_one){ Talk.create!(:title     => "Int 1",
                              :kind      => "intermediate",
                              :email     => "a@example.com",
                              :presenter => "Me")
                }
  let(:int_two){ Talk.create!(:title     => "Int 2",
                              :kind      => "intermediate",
                              :email     => "a@example.com",
                              :presenter => "Me")
                }
  let(:beg_one) { Talk.create!(:title     => "Beg 1",
                               :kind      => "beginner",
                               :email     => "a@example.com",
                               :presenter => "Me")
                }
  let(:beg_two) { Talk.create!(:title     => "Beg 2",
                               :kind      => "beginner",
                               :email     => "a@example.com",
                               :presenter => "Me")
                }
  let(:adv_one){ Talk.create!(:title     => "Adv 1",
                              :kind      => "advanced",
                              :email     => "a@example.com",
                              :presenter => "Me")
                }
  let(:adv_two) { Talk.create!(:title     => "Adv 2",
                               :kind      => "advanced",
                               :email     => "a@example.com",
                               :presenter => "Me")
                }
  let(:lit_one) { Talk.create!(:title     => "Lit 1",
                               :kind      => "lightning",
                               :email     => "a@example.com",
                               :presenter => "Me")
                }
  let(:lit_two) { Talk.create!(:title     => "Lit 2",
                               :kind      => "lightning",
                               :email     => "a@example.com",
                               :presenter => "Me")
                }
  describe 'get "INDEX"' do
    before do
      adv_two.completed = true
      adv_two.scheduled_date = 8.days.ago

      beg_two.completed = true
      beg_two.scheduled_date = 10.days.ago

      int_two.completed = true
      int_two.scheduled_date = 9.days.ago

      lit_two.completed = true
      lit_two.scheduled_date = 7.days.ago

      [adv_two, beg_two, int_two, lit_two].map(&:save!)
    end

    let(:past_talks){ [beg_two, int_two, adv_two, lit_two].map(&:title) }

    it "assigns past talks" do
      get :index
      expect(assigns(:past_talks).map(&:title)).to eq past_talks
    end


  end

end