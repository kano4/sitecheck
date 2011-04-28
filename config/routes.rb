ActionController::Routing::Routes.draw do |map|
  map.root :controller => 'top', :action => 'index'

  map.resources :sites,
    :new => { :new => :post },
    :member => { :edit => :put, :confirm => :put, :check => :get, :show_html => :get, :send_mail => :put, :check_domain => :get },
    :collection => { :confirm => :post, :all_check => :get, :all_check_domain => :get }
  map.resources :users,
		:member => { :chgpass => [:get, :post, :put], :update_chgpass => :put }
  map.resources :site_user
  map.resources :groups
  map.resources :departments
  map.resources :logs
  map.resources :configs

  map.resources :user_sessions
#  map.resources :users
	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"
end
