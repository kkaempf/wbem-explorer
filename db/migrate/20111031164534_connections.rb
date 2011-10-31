class Connections < ActiveRecord::Migration
  def up
    create_table :connections do |t|
      t.column :host_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
      t.column :protocol, :string, :default => "wsman"   # wsman or cimxml
      t.column :secure, :boolean, :default => false      # true for https, else http
      t.column :port, :integer, :default => 80
      t.column :path, :string, :default => "/wsman"
    end
    add_index :connections, [:host_id, :user_id, :protocol]
  end

  def down
    drop_index :connections
    drop_table :connections
  end
end
