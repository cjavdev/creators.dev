class AddFinancialAccountIdToAccounts < ActiveRecord::Migration[7.1]
  def change
    add_column :accounts, :financial_account_id, :string
  end
end
