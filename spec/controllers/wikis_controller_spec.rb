require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  describe "GET #index" do

    context "User not logged in" do
      it "returns http redirect to sign in" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end

    context "User is logged in" do
      # Login user before performing tests
      login_user

      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
