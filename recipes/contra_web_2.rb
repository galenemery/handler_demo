# We're rolling back to web, so we aren't going to remove httpd like we did initially

# Iterate over the apache sites and remove all traces of them
node["handler_demo"]["sites"].each do |site_name, site_data|
# Set the document root
  document_root = "/srv/apache/#{site_name}"

# Remove Apache virtual host configuration
file "/etc/httpd/conf.d/#{site_name}.conf" do
	action :delete
end


# Add a directory resource to remove the document_root
  directory document_root do
    action :delete
    recursive true
  end
end

# Re-enable the default virtual host
execute "mv /etc/httpd/conf.d/welcome.conf.disabled /etc/httpd/conf.d/welcome.conf" do 
  only_if do
    File.exist?("/etc/httpd/conf.d/welcome.conf.disabled")
  end
  notifies :restart, "service[httpd]"
end

include_recipe "handler_demo::web"