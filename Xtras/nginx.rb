package "nginx" do
  action :install
end

service "nginx" do
  action [:enable, :start]
end

file "/usr/share/nginx/html/version.txt" do
  source "version.txt"
  mode "0644"
end
