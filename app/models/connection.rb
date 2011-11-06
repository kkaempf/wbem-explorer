class Connection < ActiveRecord::Base
  has_many :hosts
  validates_uniqueness_of :name
  paginates_per 5

  def to_s
    h = Host.find(host) rescue "none"
    "#{name}: #{login}@#{h}"
  end

end
