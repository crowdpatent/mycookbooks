# Run each app. We don't expose any ports since Nginx will handle all incoming traffic as a proxy
node[:my_apps].each do |name, image|  
  env_vars = ""
  ports    = ""
  if node[:environment_variables]
    env_vars = node[:environment_variables].map {|k, v| "-e #{k}=#{v}" }.join(" ")
    puts env_vars
  end

  if node[:ports]
    ports = node[:ports].map {|k, v| "-p #{k}=#{v}" }.join(" ")
    puts ports
  end

  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d #{ports} #{env_vars} --name=#{name} #{image}
    EOH
  end
end
