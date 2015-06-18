default['handler_demo']['from_address'] = "vagrant@localhost"
default['handler_demo']['to_address'] = "vagrant@localhost"

default["handler_demo"]["indexfile"] = "index1.html"
default["handler_demo"]["sites"]["clowns"] = { "port" => 80 }
default["handler_demo"]["sites"]["bears"] = { "port" => 81 }
default["handler_demo"]["company"] = "CHEF"
