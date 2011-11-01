class Connection < ActiveRecord::Base
  has_many :hosts
  has_many :users

  def to_s
    host = Host.find(host_id) rescue "none"
    user = User.find(user_id) rescue ""
    "#{host} as #{user}"
  end

end
