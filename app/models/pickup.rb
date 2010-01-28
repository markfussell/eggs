class Pickup < ActiveRecord::Base
  belongs_to :farm
  has_many :pickups
  has_many :stock_items
  has_many :products, :through => :stock_items
  has_many :orders

  validates_presence_of :farm_id

  define_easy_dates do
    format_for :date, :format => "%A, %b%e, %Y", :as => "pretty_date"
    format_for :opening_at, :format => "%I:%M%p, %m/%d/%y" 
    format_for :closing_at, :format => "%I:%M%p, %m/%d/%y"
  end
end
