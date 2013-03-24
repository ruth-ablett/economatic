require 'transaction_collection'

class BalanceEnquiryContext
  def initialize(actors)
    @account = actors[:account]
    @account.extend TransactionCollection
  end

  def call
    @account.balance
  end
end