require 'rails_helper'

RSpec.describe Collaborator, type: :model do

  let(:collaborate_record) { Collaborator.create!(user_id: 1, wiki_id: 1) }

  describe "user attributes" do
    it "has user_id and wiki_id attributes" do
      expect(collaborate_record).to have_attributes(user_id: 1, wiki_id: 1)
    end
  end
end
