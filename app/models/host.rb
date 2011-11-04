class Host < ActiveRecord::Base
  validates_uniqueness_of :fqdn
  paginates_per 10

  def to_s
    "#{name} [#{fqdn}]"
  end

end
