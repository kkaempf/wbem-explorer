class Host < ActiveRecord::Base
  validates_uniqueness_of :fqdn

  def to_s
    "#{name} [#{fqdn}]"
  end

end
