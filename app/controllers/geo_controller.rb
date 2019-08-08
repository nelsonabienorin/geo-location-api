class GeoController < ApplicationController
  before_action :location_params, only: :inside

  def index
    render json: get_parsed_json, status: 200
  end

  def inside
    begin
      point_x = params[:point]['0'].to_f
      point_y = params[:point]['1'].to_f
      inside = LocationService.inside_location(get_parsed_json,point_x,point_y)
      render json: { type_point: is_type_point?, inside: inside }, status: :ok
    rescue StandardError => message
      render json: { message: "Something went wrong: #{message}" }, status: 500
    end
  end

  def get_parsed_json
    json_parser = JsonParserService.new('public/Given_areas.json')
    json_parser.parser
  end

  private

  def location_params
    params.permit(:point)
  end

  def is_type_point?
    params[:point].keys.count == 2 # check if inputted point is an array of 2 elements i.e. x and y
  end
end
