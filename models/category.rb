class Category < ActiveRecord::Base
  belongs_to :city
  has_many :businesses
  
  validates :category_name, uniqueness: {case_sensitive: false, scope: :city}, presence: true
  
  def category_name=(s)
    super s.titleize
  end
end
