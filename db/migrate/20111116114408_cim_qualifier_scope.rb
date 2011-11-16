class CimQualifierScope < ActiveRecord::Migration
  def up
    create_table :cim_qualifier_scopes do |t|
      t.string :name
    end
  end

  def down
    drop_table :cim_qualifier_scopes
  end
end
