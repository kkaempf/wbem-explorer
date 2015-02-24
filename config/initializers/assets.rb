# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( wbem_explorer.css wbem_explorer.js debug.js tooltip.js )
Rails.application.config.assets.precompile += %w( classes_tree_tree.js )
Rails.application.config.assets.precompile += %w( classes_graph_force.js )
Rails.application.config.assets.precompile += %w( classes_graph_tree.js )
Rails.application.config.assets.precompile += %w( classes_graph_indented.js )
Rails.application.config.assets.precompile += %w( indented.css )