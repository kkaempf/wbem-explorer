class Cimclasses < ActiveRecord::Migration
  def self.up
    create_table :cimclasses do |t|
      t.column :name, :string, :null => false
    end
  end

  def self.down
    drop_table :cimclasses
  end
end
