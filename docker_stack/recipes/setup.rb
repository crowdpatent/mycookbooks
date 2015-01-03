package "docker.io" do  
  action :install
end
node[:repos].each do |name, repo|  
  script "set_#{name}_repo" do
    interpreter "bash"
    user "root"
    code <<-EOH
      echo 'DOCKER_OPTS="$DOCKER_OPTS --insecure-registry=#{repo}"' > /etc/default/docker && sudo service docker.io restart
    EOH
  end
end
