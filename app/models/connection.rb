class Connection < ActiveRecord::Base
  belongs_to :host
  belongs_to :auth_scheme
  validates_uniqueness_of :name
  paginates_per 5

  def to_s
    h = Host.find(host) rescue "none"
    s = "#{name} ("
    if login && !login.empty?
      s << "#{login}@"
    end
    s << "#{h}:#{port})"

  end

  def to_uri
    h = Host.find(host)
    uri = "http" + (secure? ? "s" : "") + "://"
    if login
      uri += login
      if password
	uri += ":"
	uri += password
      end
      uri += "@"
    end
    uri += h.fqdn
    uri += ":"
    uri += port.to_s
    uri += path
    uri
  end
end
