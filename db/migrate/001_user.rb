class User < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login, :string, :limit => 16, :null => false
      t.column :fullname, :string, :limit => 64
      t.column :password, :string, :limit => 64
      t.column :created_at, :date
    end
  end

  def self.down
    drop_table :users
  end
end
