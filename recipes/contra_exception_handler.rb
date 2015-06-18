file "#{node['chef_handler']['handler_path']}/exception_handler.rb" do
	action :delete
end

package "mailx" do
	action :remove
end

chef_gem "pony" do
	action :remove
end
		