module Stores
  class AttachmentsController < StoreBaseController
    before_action :authenticate_customer!

    def show
      @attachment = current_customer.attachments.find(params[:id])

      send_data(
        @attachment.file.download,
        filename: @attachment.file.filename.to_s,
      )
    end
  end
end
