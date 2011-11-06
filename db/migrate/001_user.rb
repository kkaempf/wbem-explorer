class User < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :login, :limit => 16, :null => false
      t.string :fullname, :limit => 64
      t.string :password, :limit => 64
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
