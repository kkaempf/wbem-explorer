class Connections < ActiveRecord::Base
  has_many :hosts
  has_many :users

  def to_s
    "#{host} as #{user}"
  end

end
