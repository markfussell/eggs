# == Schema Information
#
# Table name: accounts
#
#  id         :integer(4)      not null, primary key
#  member_id  :integer(4)
#  farm_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Account do
  before(:each) do
    @valid_attributes = {

    }
  end

  it "should create a new instance given valid attributes" do
    Account.create!(@valid_attributes)
  end

  it "should return the current balance based on the last transaction" do
    account = Factory(:account)

    account.current_balance.should == 0

    Factory(:transaction, :amount => 100, :debit => false, :account => account)
    Factory(:transaction, :amount => 40, :debit => true, :account => account)

    account.current_balance.should == 60
  end

  it "accepts fields pertaining to new membership" do
    account = Factory.build(:account)
    account.deposit_type = "paypal"
    account.deposit_received = false
    account.joined_mailing_list = false
    account.referral = "kathryn aaker"
    account.save!
    account.pending.should == true
  end

  it "defaults new member fields to pending" do
    account = Factory.build(:account)
    account.pending.should == false
    account.deposit_received.should == true
    account.joined_mailing_list.should == true
    account.save!

    # this is because the database defaults to not pending,
    # but newly created members default to pending = true
    account.pending.should == true
    account.joined_mailing_list.should == false
    account.deposit_received.should == false
  end

    it "can be set to is_inactive" do
    account = Factory.create(:account)
    account.is_inactive.should == false

    account.update_attribute("is_inactive", true)
    account.is_inactive.should == true


  end

  describe "#calculate_balance" do
    before do
      @account = Factory(:account)

      Factory(:transaction, :amount => 100, :debit => false, :account => @account)
      transaction = Factory(:transaction, :amount => 40, :debit => true, :account => @account)
      transaction.update_attribute(:balance, 0)
    end

    it "calculates based on all transactions" do
      @account.current_balance.should == 0
      @account.calculate_balance.should == 60
    end

  end

  describe "#recalculate_balance_history!" do
    before do
      @account = Factory(:account)
      
      Factory(:transaction, :amount => 100, :debit => false, :account => @account).update_attribute(:balance, 0)
      Factory(:transaction, :amount => 40, :debit => true, :account => @account).update_attribute(:balance, 0)

    end

    it "recalculates and applies correct balances for all transactions" do
      @account.current_balance.should == 0
      @account.recalculate_balance_history!
      @account.current_balance.should == 60

      @account.transactions.first.balance.should == 100
      @account.transactions.last.balance.should == 60

    end

    it "recalculates and applies correct balances for all transactions when not 0" do
      @account.transactions.first.update_attribute(:balance, -50)
      @account.transactions.last.update_attribute(:balance, 25)

      @account.current_balance.should == 25
      @account.recalculate_balance_history!
      @account.current_balance.should == 60

      @account.transactions.first.balance.should == 100
      @account.transactions.last.balance.should == 60

    end
    
  end

end
