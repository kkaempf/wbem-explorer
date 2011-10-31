class Hosts < ActiveRecord::Base
  has_and_belongs_to_many :users
  validates_uniqueness_of :fqdn

  def to_s
    "#{name} [#{fqdn}]"
  end

end
