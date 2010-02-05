class Member < ActiveRecord::Base
  has_many :subscriptions
  has_many :farms, :through => :subscriptions
  has_many :orders

  acts_as_authentic
end
