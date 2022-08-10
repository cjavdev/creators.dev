# == Schema Information
#
# Table name: customers
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint           not null
#  stripe_id  :string
#
# Indexes
#
#  index_customers_on_store_id            (store_id)
#  index_customers_on_store_id_and_email  (store_id,email) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Customer < ApplicationRecord
  belongs_to :store
  validates :store_id, uniqueness: { scope: :email }
  has_many :customer_products
  has_many :products, through: :customer_products
end
