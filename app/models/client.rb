class Client < ActiveRecord::Base
  belongs_to :auth_scheme
  has_many :cached_namespaces
  has_many :namespaces, :through => :cached_namespaces

  validates_uniqueness_of :name
  paginates_per 5

  def to_s
    s = "#{name} ("
    if login && !login.empty?
      s << "#{login}@"
    end
    s << "#{host}:#{port}) via #{protocol}"
  end

  def to_uri
    uri = "http" + (secure? ? "s" : "") + "://"
    if login
      uri += login
      if password
	uri += ":"
	uri += password
      end
      uri += "@"
    end
    uri += host
    uri += ":"
    uri += port.to_s
    uri += path
    uri
  end
  
end
