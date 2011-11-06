class Connection < ActiveRecord::Migration
  def up
    create_table :connections do |t|
      t.string  :name # name of connection
      t.integer :host, :null => false # foreign key to Hosts
      t.string  :login, :null => false # access credentials
      t.string  :password
      t.string  :protocol, :default => "wsman"   # wsman or cimxml
      t.boolean :secure, :default => false      # true for https, else http
      t.integer :port, :default => 80
      t.string  :path, :default => "/wsman"
      t.timestamps
    end
  end

  def down
    drop_table :connections
  end
end
