class GeoController < ApplicationController
  before_action :location_params, only: :inside

  def initialize
    @inside = false

    begin
      file = File.read('Given_areas.json')
      @given_areas = JSON.parse(file)
    rescue StandardError => message
      render json: {message: "Error reading file: #{message}"}, status: 500
    end
  end

  def get_areas
    render json: @given_areas, status: 200
  end

  def inside
    begin
      point_x = params[:points]['0'].to_f
      point_y = params[:points]['1'].to_f

      @given_areas['features'].each do |feature_item|
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

      render json: { type_point: is_type_point?, inside: @inside  }, status: :ok

    rescue StandardError => message
      render json: { message: "Something went wrong: #{message}" }, status: 500
    end
  end

  def is_type_point?
    params[:points].keys.count == 2 # check if inputted point is an array of 2 elements i.e. x and y
  end

  private

  def location_params
    params.permit(:points)
  end
end
