class CimQualifier < ActiveRecord::Migration
  def up
    create_table :cim_qualifiers do |t|
      t.string :name, :null => false
      t.integer :type # reference to cim_types
      t.string :default # optional default value
      # scopes and flavors are in external join table
    end
    # class <-> scope
    create_table :cim_classes_cim_qualifier_scopes, :id => false do |t|
      t.references :cim_class, :cim_qualifier_scope
    end
    # class <-> flavor
    create_table :cim_classes_cim_qualifier_flavors, :id => false do |t|
      t.references :cim_class, :cim_qualifier_flavor
    end

    add_index :cim_qualifiers, :name
  end

  def down
    drop_table :cim_classes_cim_qualifier_flavors
    drop_table :cim_classes_cim_qualifier_scopes
    remove_index :cim_qualifiers, :name
    drop_table :cim_qualifiers
  end
end
