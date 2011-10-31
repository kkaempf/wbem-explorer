module UsersHelper
  def subnav_for_users
    [
     { :name => "New", :path => new_user_path },
     { :name => "List", :path => users_path },
     { :name => "Search", :path => search_user_path }
    ]
  end
end
