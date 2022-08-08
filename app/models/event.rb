class Event < ApplicationRecord
  enum :status, {
    pending: 'pending',
    processing: 'processing',
    processed: 'processed',
    failed: 'failed'
  }, default: 'pending'
end
