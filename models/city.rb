class City < ActiveRecord::Base
  belongs_to :state
  has_many :categories
  
  validates :city_name, uniqueness: {case_sensitive: false, scope: :state}, presence: true
  validates :state_id, presence: true
  
  def city_name=(s)
    super s.titleize
  end
end
