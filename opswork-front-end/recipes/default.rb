node[:deploy].each do |app, deploy|
   execute "bower_install" do
        script "bower and gulp" do
          interpreter "bash"
          user "root"
          cwd "/tmp"
          code <<-EOH
            npm -q -g install gulp
            npm -q -g install bower
          EOH
        end
        command "gulp default"
        command "bower install --allow-root"
        cwd "#{deploy[:deploy_to]}/current"
   end
end
