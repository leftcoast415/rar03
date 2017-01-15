class Review < ActiveRecord::Base
  belongs_to :business
  belongs_to :user
  
  validates :review_rating, :review_text, :business_id, :user_id, presence: true
end
