require 'rubygems'
require 'pony'

module NcrDemo
  class EmailMe < Chef::Handler
    
    def initialize(from_address, to_address)
      @from_address = from_address
      @to_address = to_address
    end
  
    def report
      status = "Failed"
      if success?
        status = "Successful"
    end
    
    subject = "#{status} Chef run report from #{node.name}"
    report_string = ""
    
    if ! run_status.success?
      puts "Chef run failed"
      #Alert Nagios that a run failed and have Nagios kick off the contra run
      #chef-client -r "recipe[handler_demo::contra_web_2]"
    else
      puts "Chef run succeeded"
    end
      
    
    # report on changed resources
    if ! run_status.updated_resources.empty?
      # get some info about all the changed resources!
      run_status.updated_resources.each do |r|
        report_string += "The resource #{r.name} was changed in cookbook #{r.cookbook_name} at #{r.source_line}\n"
      end
    else
      report_string += "No resources changed by chef-client\n"
    end
    
    Pony.mail(:to => @to_address,
      :from => @from_address,
      :subject => subject,
      :body => report_string)
    end
  end
end