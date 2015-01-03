# Pull each of our defined apps
node[:my_apps].each do |name, image|  
  script "pull_app_#{name}_image" do
    interpreter "bash"
    user "root"
    code <<-EOH
      service docker stop
      service docker --insecure-registry #{image.split("/")[0]} start
      docker pull #{image}
    EOH
  end
end  
