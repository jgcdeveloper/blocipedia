require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false, user: nil) }

  describe "wiki attributes" do
    it "has title, body, private and user attributes" do
      expect(my_wiki).to have_attributes(title: "New Test Wiki", body: "New wiki instance for tesing", private: false, user: nil)
    end

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_length_of(:title).is_at_least(5) }
    it { is_expected.to validate_length_of(:body).is_at_least(20) }

  end
end
