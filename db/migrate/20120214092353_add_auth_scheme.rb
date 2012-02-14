class AddAuthScheme < ActiveRecord::Migration
  def up
    create_table :auth_schemes do |t|
      t.string :scheme, :null => false
      t.integer :value
    end
    AuthScheme.create :scheme => "negotiate"
    AuthScheme.create :scheme => "none"
    AuthScheme.create :scheme => "basic"
    AuthScheme.create :scheme => "digest"
    AuthScheme.create :scheme => "passport"
    AuthScheme.create :scheme => "ntlm"
    AuthScheme.create :scheme => "gss"
    change_table :connections do |t|
      t.references :auth_scheme, :default => 1 # foreign key to auth_scheme
    end
  end

  def down
    remove_column :connections, :auth_scheme
    drop_table :auth_schemes
  end
end
