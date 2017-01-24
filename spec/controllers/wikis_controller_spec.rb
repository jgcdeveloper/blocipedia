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
      let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New Wiki Body", private: false, user: nil) }


      it "returns HTTP success" do
        get :index
        expect(response).to have_http_status(:success)
      end

      it "renders template index" do
        get :index
        expect(response).to render_template :index
      end

      it "assigns [my_wiki] to @wikis" do
        get :index
        expect(assigns(:wikis)).to eq([my_wiki])
      end
    end
  end
end
