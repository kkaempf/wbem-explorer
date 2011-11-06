class Host < ActiveRecord::Migration
  def self.up
    create_table :hosts do |t|
      t.string :name, :limit => 32, :null => false  # user readable name
      t.string :fqdn, :limit => 64, :null => false  # IP or FQDN
      t.timestamps
    end
  end

  def self.down
    drop_table :hosts
  end
end
