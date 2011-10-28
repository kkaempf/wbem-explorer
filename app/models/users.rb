class User < ActiveRecord::Base
  has_and_belongs_to_many :hosts
  validates_uniqueness_of :login
  
  def to_s
    login
  end
end
