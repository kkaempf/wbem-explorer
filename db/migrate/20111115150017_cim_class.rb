class CimClass < ActiveRecord::Migration
  def self.up
    create_table :cim_classes do |t|
      t.integer :schema # reference to cim_schema
      t.string :name, :null => false
      t.integer :parent # reference to parent id in cim_classes
    end
    add_index :cim_classes, :name
  end

  def down
    remove_index :cim_classes, :name
    drop_table :cim_classes
  end
end
