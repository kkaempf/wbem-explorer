class CachedNamespace < ActiveRecord::Base
  belongs_to :namespace
  belongs_to :client

  def to_s
    timestamp.to_s
  end

end
