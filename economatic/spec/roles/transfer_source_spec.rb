require 'spec_helper'
require 'economatic/roles/transfer_source'
require 'money'

module Economatic
  describe TransferSource do
    class WithTransferSource
      attr_accessor :minimum_balance, :bank
      def initialize(params)
        @minimum_balance = params[:minimum_balance]
        @bank = params[:bank]
      end
    end

    let(:bank) {double(:bank)}
    let(:actor) { WithTransferSource.new(minimum_balance: nil, bank: bank) }
    subject { actor.extend(TransferSource) }

    describe '.can_decrease_money?' do
      context "with no minimum balance" do
        it "will allow" do
          subject.can_decrease_money?(Money.new(10)).should be_true
        end
      end

      context "with minimum balance" do
        let(:actor) { WithTransferSource.new(minimum_balance: Money.new(-100.0), bank: bank) }

        context "with zero existing balance" do
          before do
            subject.stub(balance: Money.new(0.0))
          end

          it "will allow if transfer wouldn't take me below minimum balance" do
            subject.can_decrease_money?(Money.new(90.0)).should be_true
          end

          it "wont allow if transfer would take me below minimum balance" do
            subject.can_decrease_money?(Money.new(110.0)).should be_false
          end
        end

        context "with existing balance" do
          before do
            subject.stub(balance: Money.new(10.0))
          end

          it "will allow if my balance would not be below my minimum balance if this transfer was performed" do
            subject.can_decrease_money?(Money.new(105.0)).should be_true
          end

          it "wont allow if my balance would be below minimum balance if this transfer was performed" do
            subject.can_decrease_money?(Money.new(115.0)).should be_false
          end
        end
      end
    end
  end
end