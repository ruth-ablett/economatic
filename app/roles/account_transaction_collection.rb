require 'role'
require 'transaction'
require 'money'

module AccountTransactionCollection
  include Role

  SUM_COLUMN = :amount_cents

  actor_dependency :id

  def balance
    total = incoming_transactions.sum(SUM_COLUMN) - outgoing_transactions.sum(SUM_COLUMN)
    Money.new(total)
  end

  def transactions
    Transaction.where("source_account_id = :account_id OR destination_account_id = :account_id", {account_id: id})
  end

  private

  def outgoing_transactions
    Transaction.where(source_account_id: id)
  end

  def incoming_transactions
    Transaction.where(destination_account_id: id)
  end
end