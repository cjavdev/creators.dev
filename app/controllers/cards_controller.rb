class CardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @card = current_user.cards.find(params[:id])
  end

  def create
    @cardholder = current_user.cardholders.find(params[:cardholder_id])
    @card = @cardholder.cards.new
    if @card.save
      service = StripeCard.new(params, @card)
      service.create_card
      redirect_to cardholder_path(@cardholder)
    else
      flash[:error] = "Card not created"
      render :new
    end
  end
end
