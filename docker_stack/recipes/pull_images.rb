# Pull each of our defined apps
node[:my_apps].each do |name, image|  
  script "pull_app_#{name}_image" do
    interpreter "bash"
    user "root"
    code <<-EOH
      service docker stop
      service docker start --insecure-registry #{image.split("/")[0]}
      docker pull #{image}
    EOH
  end
end  
