# it's a branch. or more like a shrubbery
require 'watir-webdriver'
require 'csv'
require 'yaml'

laden = begin
  YAML.load(File.open("european_swallow.yaml"))
rescue ArgumentError => e
  puts "Could not parse YAML: #{e.message}"
end

browser = Watir::Browser.new #:chrome
browser.goto "https://www.google.com/maps/"

sleep 2 

# does the search box exist?
search_box_exist = browser.text_field(:class => 'tactile-searchbox-input').exists?
if search_box_exist == true
  puts 'yay, we have a directions search box!'
else 
  puts 'boo! i was expecting a directions search box'
end
 
# open the direction search box
browser.button(:id => 'searchbox-directions').click

# start point
browser.text_field(:placeholder => 'Choose starting point, or click on the map...').wait_until_present
browser.text_field(:placeholder => 'Choose starting point, or click on the map...').set laden.fetch('start')

# i deserve a drink. let's go to the Whiskey Library 
browser.text_field(:placeholder => 'Choose destination, or click on the map...').set laden.fetch('end')

# select travel mode and get directions
browser.div(:class => laden.fetch('mode')).click

# expand directions
browser.a(:class => 'cards-directions-details-link').wait_until_present
browser.a(:class => 'cards-directions-details-link').click 

# read directions
directions = browser.div(:class => 'descriptionless').wait_until_present
directions = browser.div(:class => 'descriptionless').text
puts directions # look at those pretty directions!

# save to csv
CSV.open("directions_data.csv", "wb") do |csv|
  csv << ["directions"]
  csv << [directions]
end


# obtain a screenshot of the map with the route for a "future requirement".
browser.screenshot.save 'shrubberyscreenshot.png'