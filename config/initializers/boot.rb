require 'rubygems'

if File.exists?('.env')
  env_lines = File.read(".env").split("\n")
  env_lines.each do |line|
    key, value = line.split("=")
    ENV[key] ||= value    
  end
end