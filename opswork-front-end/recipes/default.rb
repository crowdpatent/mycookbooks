node[:deploy].each do |app, deploy|
  execute "install deps" do
    cwd "#{deploy[:deploy_to]}/current"
    user "root"
    command "npm install -g gulp"
    command "npm install -g bower"
    command "ln -s /usr/bin/nodejs /usr/bin/node"
    command "echo \"{'interactive': false}\" > ~/.bowerrc"
  end

  execute "run gulp and bower" do
    cwd "#{deploy[:deploy_to]}/current"
    user "root"
    command "bower install --allow-root --config.interactive=false"
    command "gulp default"
  end
end
