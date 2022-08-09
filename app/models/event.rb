# == Schema Information
#
# Table name: events
#
#  id                :bigint           not null, primary key
#  data              :json
#  processing_errors :text
#  source            :string
#  status            :enum             default("pending"), not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
class Event < ApplicationRecord
  enum :status, {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed',
    failed: 'failed'
  }, default: 'pending'
end
