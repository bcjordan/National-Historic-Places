class User < ActiveRecord::Base
  has_many :locations
  
  validates_uniqueness_of :name
end
