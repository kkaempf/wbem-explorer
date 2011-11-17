class CimModel < ActiveRecord::Migration
  def up
    create_table :cim_models do |t|
      t.string :name
    end
  end

  def down
    drop_table :cim_models
  end
end
