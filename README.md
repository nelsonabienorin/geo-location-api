# Geo Location API 
# Task (Option 1)

This is an API to determine whether an incoming geographical location is inside at least one of the given areas in GeoJSON format

## Installation

1) `git clone ...`
2) `cd geo-location-api`
3) `bundle install`
4) `rails s`


## Run

1) To fetch list of given areas in GEOJSON format, URL looks like: http://localhost:3000/areas #GET

2) To check if the location is inside any of the given areas, URL looks like: http://localhost:3000/areas #POST

## Test

`rspec`

