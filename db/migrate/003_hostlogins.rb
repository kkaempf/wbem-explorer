class Hostlogins < ActiveRecord::Migration
  def self.up
    create_table :hosts_users do |t|
      t.column :host_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :hosts_users
  end
end
