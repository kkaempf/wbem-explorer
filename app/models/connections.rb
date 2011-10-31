class Connections < ActiveRecord::Base
  has_many :hosts
  has_many :users

  def to_s
    host = Hosts.find(host_id) rescue "none"
    user = Users.find(user_id) rescue ""
    "#{host} as #{user}"
  end

end
