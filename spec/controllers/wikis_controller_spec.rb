require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  describe "GET index" do

    context "User not logged in" do
      it "returns http redirect to sign in" do
        get :index
        expect(response).to have_http_status(:redirect)
      end
    end

    context "User is logged in" do
      # Login user before performing tests
      login_user
      let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false) }


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

  describe "GET new" do
    login_user

    it "returns HTTP success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders template new" do
      get :new
      expect(response).to render_template :new
    end

    it "creates a new @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST create" do
    login_user

    it "increases the number of wikis by 1" do
      expect{ post :create, wiki: {title: Faker::Lorem.sentence(1, word_count=4), body: Faker::Lorem.paragraph(2), private: false}}.to change(Wiki,:count).by(1)
    end

    it "assigns the new wiki to @wikis" do
      post :create, wiki: {title: Faker::Lorem.sentence(1, word_count=4), body: Faker::Lorem.paragraph(2), private: false}
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new post" do
      post :create, wiki: {title: Faker::Lorem.sentence(1, word_count=4), body: Faker::Lorem.paragraph(2), private: false}
      expect(response).to redirect_to Wiki.last
    end

  end

  describe "GET show" do
    login_user
    let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false) }

    it "returns HTTP success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET edit" do
    login_user
    let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false) }

    it "returns HTTP success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the EDIT view" do
      get :edit, {id: my_wiki.id}
      expect(response).to render_template :edit
    end

    it "assigns a wiki to be assigned to @wiki" do
      get :edit, {id: my_wiki.id}
      w = assigns(:wiki)
      expect(w.id).to eq my_wiki.id
      expect(w.title).to eq my_wiki.title
      expect(w.body).to eq my_wiki.body
    end
  end

  describe "PUT update" do
    login_user
    let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false) }

    it "updates the wiki with expected attributes" do
      new_title = Faker::Lorem.sentence(1)
      new_body = Faker::Lorem.paragraph(2)
      private_status = false
      put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body, private: private_status}
    end
  end

  describe "DELETE destroy" do
    login_user
    let(:my_wiki) { Wiki.create!(title: "New Test Wiki", body: "New wiki instance for tesing", private: false) }

    it "deletes the post" do
      delete :destroy, {id: my_wiki}
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to the index page" do
      delete :destroy, {id: my_wiki}
      expect(response).to redirect_to wikis_path
    end

  end
end
