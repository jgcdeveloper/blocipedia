require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New Wiki Body", private: false, user: nil) }

  describe "wiki attributes" do
    it "has title, body, private and user attributes" do
      expect(my_wiki).to have_attributes(title: "New Test Wiki", body: "New Wiki Body", private: false, user: nil)
    end
  end
end
