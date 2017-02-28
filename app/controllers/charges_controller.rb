# This controller will handle our stripe API
class ChargesController < ApplicationController
  rescue_from ActionController::RedirectBackError, with: :redirect_to_default
  CHARGES_COST = 1_500

  def new
    @stripe_btn_data = {
      key: Rails.configuration.stripe[:publishable_key].to_s,
      description: 'Blocipedia Premium Upgrade',
      amount: upgrade_cost
    }
  end

  def create
    @user = current_user
    # Create a stripe customer for our charge
    customer = Stripe::Customer::create(
      email: @user.email,
      card: params[:stripeToken]
    )

    charge = Stripe::Charge::create(
      customer: customer.id,
      amount: upgrade_cost,
      description: 'Premium Upgrade -> #{current_user.email}',
      currency: 'usd'
    )

    flash[:notice] = 'Success - Thank You for Upgrading!'
    perform_upgrade
    redirect_to_default

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_charge_path
  end

  private

  def upgrade_cost
    CHARGES_COST
  end

  def perform_upgrade
    @user.upgrade_user
  end

  def redirect_to_default
    redirect_to wikis_path
  end
end
