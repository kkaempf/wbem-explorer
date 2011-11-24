# Load the rails application
require File.expand_path('../application', __FILE__)

# http://stackoverflow.com/questions/4188677/ruby-on-rails-3-incompatible-character-encodings-utf-8-and-ascii-8bit-with-i18
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

# Initialize the rails application
WbemExplorer::Application.initialize!

# https://github.com/bryanbibat/pro-template-app-31/blob/d94cb74f406e79e6f2d93715a72333d33f93684e/config/environment.rb
ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
  if html_tag =~ /<label/
    %|<div class="fieldWithErrors">#{html_tag} <span class="error">#{[instance.error_message].join(', ')}</span></div>|.html_safe
  else
    html_tag
  end
end
