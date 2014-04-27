class ChargesController < ApplicationController
  def new
    @stripe_btn_hash = {
      src: "https://checkout.stripe.com/checkout.js",
      class: 'stripe-button',
      data: {
        key: "#{ Rails.configuration.stripe[:publishable_key] }",
        description: "Notewiki Private Membership - #{current_user.full_name}",
        amount: 1_000
      }
    }
  end

  def create
    @amount = params[:amount]

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    ) 

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Notewiki Private Membership - #{current_user.full_name}",
      currency: 'usd'
    )

    flash[:success] = "Thank you for your purchase, #{current_user.first_name}.  Enjoy your Private Wiki subscription."
    redirect_to user_path(current_user)
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
