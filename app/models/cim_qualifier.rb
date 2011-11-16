class CimQualifier < ActiveRecord::Base
  has_and_belongs_to_many :cim_qualifier_scopes # -> CimQualifierScope
  has_and_belongs_to_many :cim_qualifier_flavors # -> CimQualifierFlavor
  belongs_to :cim_type # -> CimType
  validates_uniqueness_of :name
  paginates_per 10

  def to_s
    name
  end
end
