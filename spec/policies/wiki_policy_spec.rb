require 'rails_helper'

describe WikiPolicy do
  subject { WikiPolicy.new(user, wiki) }

  let(:wiki) { FactoryGirl.create(:wiki) }

  context "for a standard user" do
    let(:user) { FactoryGirl.create(:user) }
      it { should permit (:show) }
  end
end
