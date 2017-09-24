class Profile < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
    
  belongs_to :user
  validates_associated :user
  
  unless @age == nil
  validates_each :age do |record, attr, value|
    record.errors.add(attr, 'cannot be in the futre') if value >= Time.now.to_date
  end  
  end
  
  def current_age
    unless age == nil
      now = Time.now.utc.to_date
      now.year - age.year - ((now.month > age.month || (now.month == age.month && now.day >= age.day)) ? 0 : 1)
    end
  end
  
end


