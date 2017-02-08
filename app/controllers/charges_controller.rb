# This controller will handle our stripe API
class ChargesController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default

  def new
    @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "Blocipedia Premium User -> #{current_user.email}",
     amount: 1500
   }
  end

  def create

    # Create a stripe customer for our charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge::create(
      customer: customer.id,
      amount: 1500,
      description: 'Premium Upgrade -> #{current_user.email}',
      currency: 'usd'
    )

    flash[:notice] = "Success - Thank You for Upgrading!"
    redirect_to wikis_path


    rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path

  end

  private

  def redirect_to_default
    redirect_to wikis_path
  end

end
