class AddAuthScheme < ActiveRecord::Migration
  def up
    create_table :auth_schemes do |t|
      t.string :scheme, :null => false
      t.integer :value
    end
    AuthScheme.create :scheme => "none", :value => Openwsman::NO_AUTH
    AuthScheme.create :scheme => "basic", :value => Openwsman::BASIC_AUTH
    AuthScheme.create :scheme => "digest", :value => Openwsman::DIGEST_AUTH
    AuthScheme.create :scheme => "passport", :value => Openwsman::PASS_AUTH
    AuthScheme.create :scheme => "ntlm", :value => Openwsman::NTLM_AUTH
    AuthScheme.create :scheme => "gss", :value => Openwsman::GSSNEGOTIATE_AUTH
    change_table :connections do |t|
      t.references :auth_scheme, :default => "basic" # foreign key to auth_scheme
    end
  end

  def down
    remove_column :connections, :auth_scheme
    drop_table :auth_schemes
  end
end
