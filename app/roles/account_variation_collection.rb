require 'role'
require 'transaction'
require 'money'

module AccountVariationCollection
  include Role

  SUM_COLUMN = :amount_cents

  actor_dependency :id
  actor_dependency :variations

  def balance
    Money.new(base_scope.sum(SUM_COLUMN))
  end

  private

  def non_pending
    base_scope.where(pending: false)
  end

  def base_scope
    variations
  end
end
