class GeoController < ApplicationController
  before_action :location_params, only: :inside

  def initialize
    file = File.read('Given_areas.json')
    @given_areas = JSON.parse(file)
    @inside = false
  end

  def get_areas
    render json: @given_areas, status: 200
  end

  def inside
    point_x = params[:points]["0"].to_f
    point_y = params[:points]["1"].to_f

    @given_areas["features"].each do |feature_item|
      coordinates_array = feature_item["geometry"]["coordinates"].first
      x_coordinates_array = []
      y_coordinates_array = []

      coordinates_array.each do |coordinate|
        x_coordinates_array.push coordinate.first
        y_coordinates_array.push coordinate.second
      end

      if (point_x >= x_coordinates_array.min && point_x <= x_coordinates_array.max) &&
          (point_y >= y_coordinates_array.min && point_y <= y_coordinates_array.max)
        @inside = true
      end
    end

    render json: { type_point: is_type_point?, inside: @inside  }, status: :ok
  end


  def is_type_point?
    params[:points].keys.count == 2 # check if point is an array of 2 elements x and y
  end

  private

  def location_params
    params.permit(:points)
  end
end
