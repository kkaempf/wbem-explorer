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
  end

  def down
    drop_table :auth_schemes
  end
end
