package "httpd"

template "/var/www/html/index.html" do
  source "index-dk.html.erb"
end

service "httpd" do
  action [ :enable, :start ]
end