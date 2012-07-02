class Namespace < ActiveRecord::Base
  has_many :cached_namespaces
  has_many :clients, :through => :cached_namespaces

  validates_uniqueness_of :name

  def to_s
    name
  end
  
end
