class ChargesController < ApplicationController
  before_action :authenticate_user!
  def new
    
  end

  def create
    @amount = 1000 #cents

    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    ) 

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Notewiki Private Membership - #{current_user.name}",
      currency: 'usd'
    )

    current_user.subscribed = true
    current_user.save!

    flash[:notice] = "Thank you for your purchase, #{current_user.name}.  Enjoy your Private Wiki subscription."
    redirect_to user_path(current_user)
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end
