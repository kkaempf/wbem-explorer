class Hosts < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.column :name, :string, :limit => 32, :null => false  # user readable name
      t.column :fqdn, :string, :limit => 64, :null => false  # IP or FQDN
      t.column :secure, :boolean, :default => false          # true for https, else http
      t.column :port, :integer, :default => 80
      t.column :path, :string, :default => "/wsman"
    end
  end

  def self.down
    drop_table :hosts
  end
end
