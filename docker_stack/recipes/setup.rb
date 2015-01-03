package "docker.io" do  
  action :install
end
node[:repos].each do |name, repo|  
  script "set_#{name}_repo" do
    interpreter "bash"
    user "root"
    code <<-EOH
      service docker stop && service docker --insecure-registry #{repo} start
    EOH
  end
end
