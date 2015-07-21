# it's a branch. or more like a shrubbery
# obtain walking directions from Google
 require 'watir-webdriver'
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
browser.text_field(:placeholder => 'Choose starting point, or click on the map...').set '400 SW 6th Ave #902, Portland, OR 97204'
# end point 
# i deserve a drink. let's go to the Whiskey Library 1124 SW Alder St, Portland, OR 97205 
browser.text_field(:placeholder => 'Choose destination, or click on the map...').set '1124 SW Alder St, Portland, OR 97205'

sleep 1

# get directions 
browser.div(:class => 'directions-walk-icon').click
# when doing data driven test, pass the travel mode icon as a parameter so that we can easily select 
# browser.div(:class => 'directions-drive-icon').click
# or browser.div(:class => 'directions-transit-icon').click
sleep 1

# expand directions
browser.a(:class => 'cards-directions-details-link').click 

sleep 2

# read directions

stepOne = browser.div(:class => 'numbered-step-content').text 
puts stepOne

# how many lines of directions are there?
# iterate through each line of directions
# save directions to csv file 

# Your solution must output the data into a csv file directions_data.csv with details for each step on one line. 

# document the method for setting up and running your automation


# bonus points
# allowing for data driven tests pulling addresses from an external file. (csv, or yml) 

# obtain a screenshot of the map with the route for a "future requirement".
browser.screenshot.save 'shubberyscreenshot.png'


# other things to consider
# obtain directions from acquired company 
# are directions in same format as directions saved above? if not, then format 
# compare directions betwixt google and acquired company 