require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders a new template" do
      get :new
      expect(response).to render_template :new
    end

    it "creates stripe_btn_data" do
      get :new
      expect(assigns(:stripe_btn_data)).not_to be_nil
    end

  end

  describe "POST #create" do

    login_user
    let(:stripe_helper) { StripeMock.create_test_helper }
    let(:customer) { Stripe::Customer.create(email: 'test@test.com', card: stripe_helper.generate_card_token) }

    before { StripeMock.start }
    after { StripeMock.stop }

    #Testing stripe customer implimentation
    it "creates a stripe customer" do
      my_customer = Stripe::Customer.create({
        email: 'test1@test.com',
        card: stripe_helper.generate_card_token
      })
      expect(my_customer.email).to eq('test1@test.com')
    end
    #Testing stripe charge implimentation
    it "creates a stripe charge" do
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: 1500,

        description: 'Test Upgrade Cost',
        currency: 'usd'
      })
    end

    it "assigns a user" do
      post :create , charge: {customer: customer.id, amount: 1500, description: 'Test Upgrade Cost', currency: 'usd'}
      expect(assigns(:user)).not_to be_nil
    end

    it "redirects to wikis path" do
      post :create , charge: {customer: customer.id, amount: 1500, description: 'Test Upgrade Cost', currency: 'usd'}
      expect(response).to redirect_to wikis_path
    end

  end

end
