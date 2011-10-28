class Featureviews < ActiveRecord::Migration
  def self.up
    create_table :featureviews do |t|
      t.column :host_id, :integer, :null => false
      t.column :cimclass_id, :integer, :null => false
      t.column :feature_id, :integer, :null => false
    end
    add_index :featureviews, [:host_id, :cimclass_id]
  end

  def self.down
    drop_index :featureviews
    drop_table :propertyviews
  end
end
