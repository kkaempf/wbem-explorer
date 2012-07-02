class CachedNamespace < ActiveRecord::Migration
  def up
    create_table :cached_namespaces do |t|
      t.references :client
      t.references :namespace
      t.timestamp :timestamp
    end
  end

  def down
    drop_table :cached_namespaces
  end
end
