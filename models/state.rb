class State < ActiveRecord::Base
  has_many :cities
  
  validates :state_name, presence: true, uniqueness: true
  validates :state_abbreviation, presence: true, length: {is:2}, uniqueness: true
  
  def state_abbreviation=(s)
    super s.upcase
  end
  
  def state_name=(s)
    super s.titleize
  end
  
  def to_param
  state_name
  end
end
