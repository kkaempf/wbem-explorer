class User < ActiveRecord::Base
  validates_uniqueness_of :login
  paginates_per 10

  def to_s
    login
  end
end
