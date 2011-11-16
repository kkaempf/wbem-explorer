class CimClass < ActiveRecord::Base
  belongs_to :cim_schema
  # self reference for parent
  belongs_to :parent, :class_name => "CimClass", :foreign_key => "parent_id"
  validates_uniqueness_of :name
  paginates_per 10

  def to_s
    name
  end
end
