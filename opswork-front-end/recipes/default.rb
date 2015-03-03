node[:deploy].each do |app, deploy|
  execute "install deps and run setup" do
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    command "ln -s /usr/bin/nodejs /usr/bin/node"
    command "npm install -g gulp"
    command "npm install -g bower"
    command "npm install"
    command "bower install --allow-root --config.interactive=false"
    command "gulp default"
  end
end
