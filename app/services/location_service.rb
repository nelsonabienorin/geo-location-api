class LocationService
  def self.inside_location (get_parsed_json,point_x,point_y)
    @inside = false
    get_parsed_json['features'].each do |feature_item|
      coordinates_array = feature_item['geometry']['coordinates'].first
      x_coordinates_array = []
      y_coordinates_array = []

      coordinates_array.each do |coordinate|
        x_coordinates_array.push coordinate.first
        y_coordinates_array.push coordinate.second
      end

      condition_x = point_x.between?(x_coordinates_array.min, x_coordinates_array.max)
      condition_y = point_y.between?(y_coordinates_array.min, y_coordinates_array.max)
      @inside = true if condition_x && condition_y # check if point x and y are located within the geometry
    end
    @inside
  end
end