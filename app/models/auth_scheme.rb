class AuthScheme < ActiveRecord::Base
  validates_uniqueness_of :scheme

  def to_s
    "#{scheme}"
  end

end
