# this is no longer current 
# please use shrubbery.rb



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

# sometimes the page doesn't render immediately. let's allow for that
sleep 1

# start point
browser.text_field(:placeholder => 'Choose starting point, or click on the map...').set laden.fetch('start')
# i deserve a drink. let's go to the Whiskey Library 
browser.text_field(:placeholder => 'Choose destination, or click on the map...').set laden.fetch('end')

sleep 1

# get directions 
browser.div(:class => laden.fetch('mode')).click

sleep 1

# expand directions
browser.a(:class => 'cards-directions-details-link').click 

sleep 2

# read directions
all_directions = browser.div(:class => 'descriptionless').text
puts all_directions # later i can remove this, just want to see it on the command line before saving to csv

# Your solution must output the data into a csv file directions_data.csv with details for each step on one line. 
CSV.open("directions_data.csv", "wb") do |csv|
  csv << ["directions"]
  csv << [all_directions]
end


# obtain a screenshot of the map with the route for a "future requirement".
browser.screenshot.save 'shubberyscreenshot.png'


