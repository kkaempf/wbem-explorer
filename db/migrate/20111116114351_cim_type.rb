class CimType < ActiveRecord::Migration
  def up
    create_table :cim_types do |t|
      t.string :name, :null => false
    end
    add_index :cim_types, :name
  end

  def down
    remove_index :cim_types, :name
    drop_table :cim_types
  end
end
