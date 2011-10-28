class Features < ActiveRecord::Migration
  def self.up
    create_table :features  do |t|
      t.column :name, :string, :null => false
    end
    add_index :features, [:name]
  end

  def self.down
    drop_index :features
    drop_table :features
  end
end
