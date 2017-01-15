class Business < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  
  validates :business_name, presence: true
  validates :category_id, presence: true
  
  def business_name=(s)
    super s.titleize
  end
end
