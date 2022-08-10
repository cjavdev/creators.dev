class AttachmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    product = current_user.products.find(params[:product_id])
    @attachment = product.attachments.new(attachment_params)

    if !@attachment.save
      flash[:error] = @attachment.errors.full_messages.join(', ')
    end

    redirect_to product_path(product)
  end

  private

  def attachment_params
    params.require(:attachment).permit(:file, :name)
  end
end
