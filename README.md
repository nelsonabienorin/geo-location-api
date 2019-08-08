# Geo Location API 
# Task (Option 1)

This is an API to determine whether an incoming geographical location is inside at least one of the given areas in GeoJSON format

## Installation

1) `git clone ...`
2) `cd geo-location-api`
3) `bundle install`
4) `rails s`


## Run

1) Home, URL is https://geo-locate-api.herokuapp.com
![Home](https://drive.google.com/file/d/1TgXCIAXbcwbnuPjoqpPG0DZFKa0wvxtH/view)

2) To fetch list of given areas in GEOJSON format, URL is https://geo-locate-api.herokuapp.com/areas #GET
![Get Areas](https://drive.google.com/file/d/1SgktA9y04_Zqox3KxGT-l5Lx91V-NxcL/view)

3) To check if the location is inside any of the given areas, URL is https://geo-locate-api.herokuapp.com/areas #POST
![Post_Inside](https://drive.google.com/file/d/1kBMtQKugKNZeFcWgKbLXxtmtyiEHNTVZ/view)
For (3) above i.e. POST request, the key-value bulk edit input format should be like the one below as shown above
``point[0]:-117.86
  point[1]:50.23``

## Test

`rspec`

