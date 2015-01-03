package "docker" do  
  package_name "lxc-docker-0.9.0"
  action :install
end
node[:repos].each do |name, repo|  
  script "set_#{name}_repo" do
    interpreter "bash"
    user "root"
    code <<-EOH
      service docker stop && service docker start --insecure-registry #{repo}
    EOH
  end
end
