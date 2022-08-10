module Stores
  class StoreBaseController < ApplicationController
    layout 'stores'
    before_action :set_store

    def set_store
      @store ||= Store.find_by_request(request)
    end
  end
end
