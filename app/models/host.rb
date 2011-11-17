class Host < ActiveRecord::Base
  validates_uniqueness_of :name
  paginates_per 5
  has_many :connections

  def to_s
    "#{name} [#{fqdn}]"
  end

end
