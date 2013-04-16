require 'role'

module ApproveableTransaction
  include Role

  def approve_variations!
    variations.where(pending: true).each do |variation|
      variation.pending = false
      variation.save!
    end
  end
end