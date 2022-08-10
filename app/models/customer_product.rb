# == Schema Information
#
# Table name: customer_products
#
#  id                  :bigint           not null, primary key
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  checkout_session_id :string
#  customer_id         :bigint           not null
#  product_id          :bigint           not null
#
# Indexes
#
#  customer_product_session_index          (customer_id,product_id,checkout_session_id) UNIQUE
#  index_customer_products_on_customer_id  (customer_id)
#  index_customer_products_on_product_id   (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (customer_id => customers.id)
#  fk_rails_...  (product_id => products.id)
#
class CustomerProduct < ApplicationRecord
  belongs_to :customer
  belongs_to :product
end
