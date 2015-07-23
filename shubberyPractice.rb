# it's a branch. or more like a shrubbery
# obtain walking directions from Google
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

# everything from here on down can be deleted

# other things to consider
# obtain directions from acquired company 
# are directions in same format as directions_data.csv ? if not, then format 
# compare directions betwixt google and acquired company 


# failed bits and pieces

#step_one = browser.div(:class => 'numbered-step-content').text 
#step_one = browser.div(:class => 'directions-mode-step-container').text
#step_one = browser.div(:class => 'directions-mode-step').text
#puts step_one 


#browser.text_field(:id => "text").value

#step_two = browser.divs[1].when_present.text
#puts step_two

#step_two = browser.div(:class => 'directions-mode-step-container').jsinstance(:index => 1)
#puts step_two

#step_index1 = browser.div(:index, 2 => 'jsinstance').text
#puts step_index1


#step_index1 = browser.div(:class => 'directions-mode-step').stepindex
#puts step_index1
#step_index2 = browser.div(:class => 'directions-mode-step-stepindex').text
#puts step_index2
#step_index3 = browser.div(:class => 'directions-mode-step.stepindex').text
#puts step_index3
#step_index4 = browser.div(:class => 'stepindex').text
#puts step_index4