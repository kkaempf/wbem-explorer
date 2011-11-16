class CimSchema < ActiveRecord::Migration
  def up
    create_table :cim_schemas do |t|
      t.string :name
    end
  end

  def down
    drop_table :cim_schemas
  end
end
