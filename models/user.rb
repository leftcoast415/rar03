class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :reviews
  has_one :profile, dependent: :destroy
  
  validates :email, presence: true, uniqueness: true
  validates :username, presence: true
  
  after_create :build_profile

  def build_profile
    Profile.create(user: self)
  end
  
  accepts_nested_attributes_for :profile
  
end
