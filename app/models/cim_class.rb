class CimClass < ActiveRecord::Base
  belongs_to :cim_schema
  belongs_to :cim_class # parent
  validates_uniqueness_of :name
  paginates_per 10

  def to_s
    name
  end
end
