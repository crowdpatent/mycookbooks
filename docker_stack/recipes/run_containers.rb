# Run each app. We don't expose any ports since Nginx will handle all incoming traffic as a proxy
node[:environment_variables].each do |name, value|
    ENV["#{name}"] = "#{value}"
end
node[:my_apps].each do |name, image|  
  env_vars = ENV.map {|k, v| "-e #{k}=#{v}" }.join(" ")
  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d -p 3000:3000 #{env_vars} --name=#{name} #{image}
        -e RAILS_ENV=development \
        -e SECRET_KEY_BASE=#{ENV['SECRET_KEY_BASE']} \
        -e DB_HOST=#{ENV['DB_HOST']} \
        -e DB_USER=#{ENV['DB_USER']} \
        -e DB_PASSWORD=#{ENV['DB_PASSWORD']} \
        -e CP_BASIC_AUTH_USER=#{ENV['CP_BASIC_AUTH_USER']} \
        -e CP_BASIC_AUTH_PASSWORD=#{ENV['CP_BASIC_AUTH_PASSWORD']} \
        --name=#{name} #{image}
    EOH
  end
end
