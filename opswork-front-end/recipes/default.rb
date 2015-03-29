node[:deploy].each do |app, deploy|
  bash "install deps and run setup" do
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    ln -s /usr/bin/nodejs /usr/bin/node
    npm cache clean
    npm install
    npm install -g gulp
    npm install -g bower
    bower install --allow-root --config.interactive=false
    gulp default
    ./install_wkhtml.sh
    EOH
  end
end
