class StaticPagesController < ApplicationController
  layout 'marketing'
  def root
    render :root
  end
end
