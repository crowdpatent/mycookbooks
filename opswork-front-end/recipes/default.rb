node[:deploy].each do |app, deploy|
  execute "bower_install" do
    command "npm -q -g install gulp"
    command "npm -q -g install bower"
    command "gulp default"
    command "bower install --allow-root"
    cwd "#{deploy[:deploy_to]}/current"
   end
end
