ActionController::Routing::Routes.draw do |map|
  map.resources :ips, :collection => {:new_ipv6 => :get}
  map.resources :ipv4s, :controller => :ips
  map.resources :ipv6s, :controller => :ips
  
  map.root :controller => :ips

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
