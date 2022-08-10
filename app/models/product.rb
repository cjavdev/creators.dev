# == Schema Information
#
# Table name: products
#
#  id              :bigint           not null, primary key
#  data            :json
#  description     :text
#  name            :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  stripe_id       :string
#  stripe_price_id :string
#  user_id         :bigint           not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Product < ApplicationRecord
  validates :name, presence: true
  validates :description, presence: true
  belongs_to :user
  has_one_attached :photo do |photo|
    photo.variant :thumb, resize_to_limit: [100, 100]
    photo.variant :medium, resize_to_limit: [400, 400]
  end

  def product_data
    return if data.blank?
    Stripe::Product.construct_from(JSON.parse(data))
  end
end
