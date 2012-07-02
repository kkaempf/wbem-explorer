class Namespace < ActiveRecord::Migration
  def up
    create_table :namespaces do |t|
      t.string :name
    end
  end

  def down
    drop_table :namespaces
  end
end
