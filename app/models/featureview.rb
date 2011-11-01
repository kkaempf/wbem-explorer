class Featureview < ActiveRecord::Base

  def to_s
    "Featureview #{host_id}:[#{cimclass_id},#{feature_id}]"
  end

end
