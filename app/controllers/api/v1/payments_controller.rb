class Api::V1::PaymentsController < ApplicationController
  def create
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        price_data: {
          currency: 'inr',
          product_data: { name: 'Order Payment' },
          unit_amount: params[:amount]
        },
        quantity: 1
      }],
      mode: 'payment',
      success_url: "http://localhost:3000/success",
      cancel_url: "http://localhost:3000/cancel"
    )

    render json: { url: session.url }
  end
end
