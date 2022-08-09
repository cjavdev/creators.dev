# == Schema Information
#
# Table name: accounts
#
#  id                   :bigint           not null, primary key
#  charges_enabled      :boolean
#  payouts_enabled      :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  external_account_id  :string
#  financial_account_id :string
#  stripe_id            :string
#  user_id              :bigint           not null
#
# Indexes
#
#  index_accounts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Account < ApplicationRecord
  belongs_to :user
end
