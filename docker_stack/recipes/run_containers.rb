# Run each app. We don't expose any ports since Nginx will handle all incoming traffic as a proxy
node[:my_apps].each do |name, image|  
  env_vars = node[:environment_variables].map {|k, v| "-e #{k}=#{v}" }.join(" ")
  puts env_vars
  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d -p 3000:3000 #{env_vars} --name=#{name} #{image}
    EOH
  end
end
