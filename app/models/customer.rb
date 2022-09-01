# == Schema Information
#
# Table name: customers
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  session_token    :string
#  token_expires_at :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  store_id         :bigint           not null
#  stripe_id        :string
#
# Indexes
#
#  index_customers_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Customer < ApplicationRecord
  belongs_to :store
  has_many :customer_products
  has_many :products, through: :customer_products
  has_many :attachments, through: :products

  after_commit on: :create do
    reset_session_token!
  end

  def reset_session_token!
    update!(
      session_token: SecureRandom.urlsafe_base64,
      token_expires_at: 1.day.from_now
    )
  end
end
