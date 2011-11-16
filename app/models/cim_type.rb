class CimType < ActiveRecord::Base
  validates_uniqueness_of :name
  paginates_per 10

  def to_s
    name
  end
end
