node[:deploy].each do |app, deploy|
   execute "bower_install" do
        command "bower install --allow-root"
        cwd "#{deploy[:deploy_to]}/current"
   end
end
