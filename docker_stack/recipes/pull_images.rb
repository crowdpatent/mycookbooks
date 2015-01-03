# Pull each of our defined apps
node[:my_apps].each do |name, image, registry|  
  script "pull_app_#{name}_image" do
    interpreter "bash"
    user "root"
    code <<-EOH
      /etc/init.d/docker stop
      /etc/init.d/docker start --insecure-registry #{registry}
      docker pull #{image}
    EOH
  end
end  
