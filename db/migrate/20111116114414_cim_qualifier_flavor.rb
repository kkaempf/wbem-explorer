class CimQualifierFlavor < ActiveRecord::Migration
  def up
    create_table :cim_qualifier_flavors do |t|
      t.string :name
    end
  end

  def down
    drop_table :cim_qualifier_flavors
  end
end
