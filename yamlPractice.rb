require 'yaml'

laden = begin
  YAML.load(File.open("european_swallow.yaml"))
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
end

puts laden.fetch('start')
puts laden.fetch('end')
puts laden.fetch('mode')