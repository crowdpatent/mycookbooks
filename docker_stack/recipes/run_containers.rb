# Run each app. We don't expose any ports since Nginx will handle all incoming traffic as a proxy
node[:environment_variables].each do |name, value|
    ENV["#{name}"] = "#{value}"
end
node[:my_apps].each do |name, image|  
  script "run_app_#{name}_container" do
    interpreter "bash"
    user "root"
    code <<-EOH
      docker run -d -p 3000:3000 -e DB_HOST="#{ENV['DB_HOST']}" -e DB_USER="#{ENV['DB_USER']}" -e DB_PASSWORD="#{ENV['DB_PASSWORD']}" --name=#{name} #{image}
    EOH
  end
end
