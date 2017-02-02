require 'rails_helper'

RSpec.describe User, type: :model do
  let(:current_user) { User.create!(name: "Test User", email: "test@test.com", password: "testtest", password_confirmation: "testtest") }

  describe "user attributes" do
    it "has name, email, password, and password_confirmation attributes" do
      expect(current_user).to have_attributes(name: "Test User", email: "test@test.com", password: "testtest", password_confirmation: "testtest")
    end

    it "has a role attribute set by default to standard" do
      expect(current_user).to have_attributes(role: "standard")
    end
  end
end
