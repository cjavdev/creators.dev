# == Schema Information
#
# Table name: attachments
#
#  id          :bigint           not null, primary key
#  name        :string
#  views_count :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :bigint           not null
#
# Indexes
#
#  index_attachments_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
class Attachment < ApplicationRecord
  belongs_to :product
  has_many :attachment_views, dependent: :destroy
  has_one_attached :file
end
