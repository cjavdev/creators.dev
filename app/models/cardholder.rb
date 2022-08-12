# == Schema Information
#
# Table name: cardholders
#
#  id         :bigint           not null, primary key
#  data       :json
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  stripe_id  :string
#  user_id    :bigint           not null
#
# Indexes
#
#  index_cardholders_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Cardholder < ApplicationRecord
  belongs_to :user
  has_one :account, through: :user
  has_many :cards, dependent: :destroy
end
