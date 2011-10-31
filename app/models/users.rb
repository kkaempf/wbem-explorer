class Users < ActiveRecord::Base
  validates_uniqueness_of :login

  def to_s
    login
  end
end
