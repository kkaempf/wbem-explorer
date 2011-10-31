class Connections < ActiveRecord::Migration
  def up
    create_table :connections do |t|
      t.column :host_id, :integer, :null => false
      t.column :user_id, :integer, :null => false
    end
    add_index :connections, [:host_id, :user_id]
  end

  def down
    drop_index :connections
    drop_table :connections
  end
end
