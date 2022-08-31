module Stores
  class AttachmentsController < StoreBaseController
    def show
      @attachment = Attachment.find(params[:id])

      send_data(
        @attachment.file.download,
        filename: @attachment.file.filename.to_s,
      )
    end
  end
end
